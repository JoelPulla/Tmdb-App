import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_app_dio/config/helpers/human_formats.dart';
import 'package:tmdb_app_dio/domain/entities/movie.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String quey);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  StreamController<bool> isLoadingstream = StreamController.broadcast();

  Timer? _debounceTimer;
  List<Movie> initialMovie;
  final SearchMoviesCallback searchMovies;

  SearchMovieDelegate({
    required this.initialMovie,
    required this.searchMovies,
  }) : super(searchFieldLabel: 'Search Movie');

  void clearStreams() {
    debouncedMovies.close();
  }

  void _onQueryChanged(String query) {
    isLoadingstream.add(true);
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 900), () async {
      // if (query.isEmpty) {
      //   debouncedMovies.add([]);
      //   return;
      // }

      final movies = await searchMovies(query);
      initialMovie = movies;
      debouncedMovies.add(movies);
      isLoadingstream.add(false);
    });
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    final themeCOlor = Theme.of(context).colorScheme;
    return [
      StreamBuilder(
        stream: isLoadingstream.stream,
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
            return SpinPerfect(
              duration: const Duration(seconds: 3),
              spins: 10,
              infinite: true,
              child: IconButton(
                onPressed: () => query = '',
                icon: Icon(
                  Icons.refresh,
                  color: themeCOlor.primary,
                ),
              ),
            );
          }
          return FadeIn(
            animate: query.isNotEmpty,
            child: IconButton(
              onPressed: () => query = '',
              icon: Icon(
                Icons.close_sharp,
                color: themeCOlor.primary,
              ),
            ),
          );
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          clearStreams();
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded));
  }

  Widget buildResultsAndSuggestions() {
    return StreamBuilder(
      initialData: initialMovie,
      stream: debouncedMovies.stream,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return _MovieItem(
              movie: movies[index],
              onMovieSelected: (context, movie) {
                clearStreams();
                close(context, movie);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //* *//
    _onQueryChanged(query);
    return buildResultsAndSuggestions();
  }
}

class _MovieItem extends StatelessWidget {
  final Function onMovieSelected;
  final Movie movie;

  const _MovieItem({
    required this.movie,
    required this.onMovieSelected,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final themeText = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: GestureDetector(
        onTap: () {
          onMovieSelected(context, movie);
        },
        child: Row(
          children: [
            //* Image
            SizedBox(
              height: size.height * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) =>
                      FadeIn(child: child),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),

            //* Text
            SizedBox(
              width: size.width * 0.67,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: themeText.titleMedium,
                  ),
                  const SizedBox(height: 5),
                  (movie.overview.length > 100)
                      ? Text(
                          '${movie.overview.substring(0, 100)} ...',
                          style: themeText.bodySmall,
                        )
                      : Text(
                          movie.overview,
                          style: themeText.bodySmall,
                        ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_half_outlined,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 5),
                      Text(HumanFormats.numberFormat(movie.voteAverage, 1)),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
