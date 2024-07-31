import 'package:tmdb_app_dio/domain/datasource/movies_datasource.dart';
import 'package:tmdb_app_dio/domain/entities/movie.dart';
import 'package:tmdb_app_dio/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {
  final MoviesDatasource datasource;
  MovieRepositoryImpl(this.datasource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getPolar({int page = 1}) {
    return datasource.getPopular(page: page);
  }

  @override
  Future<List<Movie>> getUpCpming({int page = 1}) {
    return datasource.getUpCpming(page: page);
  }
  
  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return datasource.getTopRated(page: page);
  }
  
  @override
  Future<Movie> getMovieById(String id) {
    return datasource.getMovieById(id);
  }
}
