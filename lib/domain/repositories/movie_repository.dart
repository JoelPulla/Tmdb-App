import 'package:tmdb_app_dio/domain/entities/movie.dart';

// Desde aqui llamamos a nuestro Data Source
abstract class MoviesRepository {
  Future<List<Movie>> getNowPlaying({int page = 1});
}
