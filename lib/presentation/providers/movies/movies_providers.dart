import 'package:tmdb_app_dio/domain/entities/movie.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_app_dio/presentation/providers/movies/movies_provider.dart';

final nowPlaygiMovieProvider =
    StateNotifierProvider<MoviesNotfier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;
  return MoviesNotfier(fetchMoreMovies: fetchMoreMovies);
});

typedef MovieCallBack = Future<List<Movie>> Function({int page});

class MoviesNotfier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  MovieCallBack fetchMoreMovies;

  MoviesNotfier({
    required this.fetchMoreMovies,
  }) : super([]);

  Future<void> loadNextPage() async {
    currentPage++;

    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...movies];
  }
}
