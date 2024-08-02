import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_app_dio/config/helpers/human_formats.dart';
import 'package:tmdb_app_dio/domain/entities/movie.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String quey);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMovies;

  SearchMovieDelegate({
    required this.searchMovies,
  });

  @override
  List<Widget>? buildActions(BuildContext context) {
    final themeCOlor = Theme.of(context).colorScheme;

    return [
      FadeIn(
        animate: query.isNotEmpty,
        child: IconButton(
          onPressed: () => query = '',
          icon: Icon(
            Icons.close,
            color: themeCOlor.primary,
          ),
        ),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('resutls');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: searchMovies(query),
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return _MovieItem(
              movie: movies[index],
              onMovieSelected: close,
            );
          },
        );
      },
    );
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
