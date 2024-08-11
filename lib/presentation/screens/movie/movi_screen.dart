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
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];
    if (movie == null) {
      return const FullScreenLoading();
    }
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 1,
              (context, index) => _MovieDetails(movie: movie),
            ),
          )
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;

  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final themeText = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ImageBackground(movie: movie),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'Elenco',
            style: themeText.titleMedium,
          ),
        ),
        //* Actores de la película
        ActorsByMovie(movieId: movie.id.toString()),

        //* Video Trailer*//
        VideosFromMovie(movieId: movie.id),

        const SizedBox(
          height: 300,
        )
      ],
    );
  }
}

class _ImageBackground extends ConsumerWidget {
  final Movie movie;
  const _ImageBackground({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context, ref) {
    final isFavoriteFuture = ref.watch(isFavoriteProvider(movie.id));
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.7,
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: size.height * 0.6,
            child: Image.network(
              movie.posterPath,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: size.height * 0.7,
            child: const UiGradient(
              data: Alignment.bottomRight,
            ),
          ),
          Positioned(
            left: 16,
            bottom: 20,
            child: _TitleAndOverview(
              movie: movie,
              size: size,
            ),
          ),
          const UiGradientTop(data: Alignment.topRight),
          Positioned(
            top: 35,
            left: 1,
            child: IconButton(
              onPressed: () {
                context.pop('/home/0');
              },
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
          ),
          Positioned(
            right: 1,
            top: 35,
            child: IconButton(
              onPressed: () async {
                await ref
                    .read(favoritesMoviesProvider.notifier)
                    .toggleFavorites(movie);

                ref.invalidate(isFavoriteProvider(movie.id));
              },
              icon: isFavoriteFuture.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                data: (isFavorite) => isFavorite
                    ? const Icon(Icons.favorite_rounded, color: Colors.red)
                    : const Icon(Icons.favorite_border),
                error: (_, __) => throw UnimplementedError(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//* Porvider
final isFavoriteProvider =
    FutureProvider.family.autoDispose((ref, int movieId) {
  final localStorageRepository = ref.watch(localStorageRepositoryprovider);
  return localStorageRepository.isMovieFavorite(movieId);
});

class _TitleAndOverview extends StatelessWidget {
  final Movie movie;
  final Size size;

  const _TitleAndOverview({required this.movie, required this.size});

  @override
  Widget build(BuildContext context) {
    final themeText = Theme.of(context).textTheme;
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MovieRating(voteAverage: movie.voteAverage),
          Text(movie.title,
              style:
                  themeText.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          //* Generos de la película
          _Genres(movie: movie),
          const SizedBox(height: 10),
          SizedBox(
            width: 600,
            child: Text(
              movie.overview,
              style: themeText.bodyMedium,
              maxLines: 3,
            ),
          ),

          const SizedBox(height: 10),

          // const Row(
          //   children: [
          //     Text('Estreno:', style: TextStyle(fontWeight: FontWeight.bold)),
          //     SizedBox(width: 5),
          //     // Text('${movie.releaseDate}')
          //   ],
          // ),
          // LinearGradientButton(),
          //const SizedBox(height: 15)
        ],
      ),
    );
  }
}

class _Genres extends StatelessWidget {
  const _Genres({
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      alignment: WrapAlignment.start,
      children: [
        ...movie.genreIds.map(
          (gender) => Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: colorTheme.primary),
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.only(right: 10),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                gender,
                style: TextStyle(fontSize: 8, color: colorTheme.primary),
              ),
            ),
          ),
        )
      ],
    );
  }
}
