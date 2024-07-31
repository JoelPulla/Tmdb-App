import 'package:tmdb_app_dio/domain/entities/movie.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_app_dio/presentation/providers/movies/movies_provider.dart';

final nowPlaygiMoviesProvider = StateNotifierProvider<MoviesNotfier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;
  return MoviesNotfier(fetchMoreMovies: fetchMoreMovies);
});

final popularMoviesPrivider = StateNotifierProvider<MoviesNotfier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getPolar;
  return MoviesNotfier(fetchMoreMovies: fetchMoreMovies);
});

final upCominMoviesProvider = StateNotifierProvider<MoviesNotfier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getUpCpming;
  return MoviesNotfier(fetchMoreMovies: fetchMoreMovies);
});

final topRatedProvider = StateNotifierProvider<MoviesNotfier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getTopRated;

  return MoviesNotfier(fetchMoreMovies: fetchMoreMovies);
});















//*
typedef MovieCallBack = Future<List<Movie>> Function({int page});
class MoviesNotfier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  bool isLoading = false;
  MovieCallBack fetchMoreMovies;

  MoviesNotfier({
    required this.fetchMoreMovies,
  }) : super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;

    isLoading = true;
    currentPage++;

    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...movies];

    await Future.delayed(const Duration(microseconds: 400));
    isLoading = false;
  }
}
