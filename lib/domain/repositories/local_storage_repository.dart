import 'package:tmdb_app_dio/domain/entities/movie.dart';

abstract class LocalStorageRepository {
  Future<void> toggleFavorites(Movie movie);

  Future<bool> isMovieFavorite(int movieId);

  Future<List<Movie>> loadMovies({int limit = 10, offset = 0});
}
