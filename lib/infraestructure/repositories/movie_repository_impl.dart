import 'package:tmdb_app_dio/domain/datasource/movies_datasource.dart';
import 'package:tmdb_app_dio/domain/entities/movie.dart';
import 'package:tmdb_app_dio/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {
  final MoviesDatasource datasource;

  MovieRepositoryImpl(this.datasource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    //Repository
    return datasource.getNowPlaying(page: page);
  }
}
