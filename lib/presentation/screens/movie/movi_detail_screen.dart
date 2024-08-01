import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:tmdb_app_dio/domain/entities/movie.dart';
import 'package:tmdb_app_dio/presentation/providers/providers.dart';
import 'package:tmdb_app_dio/presentation/widgets/widgets.dart';

class MovieDetailScreen extends ConsumerStatefulWidget {
  static const name = 'movie_detail_screen';
  final String movieId;

  const MovieDetailScreen({
    super.key,
    required this.movieId,
  });

  @override
  MovieDetailScreenState createState() => MovieDetailScreenState();
}

class MovieDetailScreenState extends ConsumerState<MovieDetailScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final themeText = Theme.of(context).textTheme;
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];
    if (movie == null) {
      return const FullScreenLoading();
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _AppBarImage(
              movie: movie,
            ),
            const SizedBox(height: 20),

            Wrap(
              alignment: WrapAlignment.center,
              spacing: 5,
              children: [
                ...movie.genreIds.map(
                  (gender) => Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(24, 151, 144, 127),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      child: Text(
                        gender,
                        style: themeText.bodySmall,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),

            //* Actors *//
            _ActorsByMovie(movieId: movie.id.toString()),
            Container(
              height: 250,
              width: 300,
              color: Colors.amber,
            ),
            const SizedBox(height: 600),
          ],
        ),
      ),
    );
  }
}

class _AppBarImage extends StatelessWidget {
  final Movie movie;
  const _AppBarImage({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final themeText = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        //* Image
        SizedBox(
          height: size.height * 0.6,
          child: Image.network(
            movie.backdropPath,
            fit: BoxFit.cover,
          ),
        ),

        //* Gradient
        const UiGradient(data: Alignment.bottomRight),
        const UiGradientTop(data: Alignment.topRight),

        //* Image and Description
        Positioned(
          left: 25,
          bottom: 10,
          child: Row(
            children: [
              SizedBox(
                height: 150,
                width: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    movie.posterPath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: themeText.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 5),
                    width: 200,
                    child: Text(
                      movie.overview,
                      style: themeText.bodySmall,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_half_outlined,
                        color: Colors.amber,
                      ),
                      Text(movie.popularity.toString())
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
        Positioned(
            top: 20,
            child: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(Icons.arrow_back_ios_rounded)))
      ],
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  final String movieId;
  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, ref) {
    final themeText = Theme.of(context).textTheme;

    final actorsByMovie = ref.watch(actorsByMovieProvider);

    if (actorsByMovie[movieId] == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final actors = actorsByMovie[movieId]!;

    return SizedBox(
      height: 300,
      child: ListView.builder(
        itemCount: actors.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final actor = actors[index];
          return Container(
            padding: const EdgeInsets.only(left: 5),
            width: 110,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(actor.profilePath),
                ),
                Text(
                  actor.name,
                  style: themeText.bodyMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  actor.character ?? '',
                  style: themeText.labelSmall!.copyWith(
                      color: const Color.fromARGB(255, 106, 106, 106)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
