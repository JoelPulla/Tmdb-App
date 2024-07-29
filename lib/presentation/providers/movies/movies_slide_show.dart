import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_app_dio/presentation/providers/providers.dart';

import 'package:tmdb_app_dio/domain/entities/movie.dart';

//Este provider me retorna un lista recordata de mi getnowplayingprovider
final moviesSliderShowProvider = Provider<List<Movie>>((ref) {
  final nowPlayingMovies = ref.watch(nowPlaygiMoviesProvider);

  if (nowPlayingMovies.isEmpty) return [];

  return nowPlayingMovies.sublist(0, 6);
});
