import 'package:tmdb_app_dio/domain/entities/movie.dart';

// Desde aqui llamamos a nuestro Data Source
abstract class MoviesRepository {
  Future<List<Movie>> getNowPlaying({int page = 1});

  Future<List<Movie>> getPolar({int page = 1});

  Future<List<Movie>> getUpCpming({int page = 1});

  Future<List<Movie>> getTopRated({int page = 1});

  Future<Movie> getMovieById(String id);

  Future<List<Movie>> searchMovies(String query);
}
