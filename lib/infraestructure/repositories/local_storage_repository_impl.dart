import 'package:tmdb_app_dio/domain/datasource/local_storage_datasource.dart';
import 'package:tmdb_app_dio/domain/entities/movie.dart';
import 'package:tmdb_app_dio/domain/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {
  final LocalStorageDatasource datasource;

  LocalStorageRepositoryImpl(this.datasource);

  @override
  Future<bool> isMovieFavorite(int movieId) {
    return datasource.isMovieFavorite(movieId);
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) {
    return datasource.loadMovies(limit: limit, offset: offset);
  }

  @override
  Future<void> toggleFavorites(Movie movie) {
    return datasource.toggleFavorites(movie);
  }
}
