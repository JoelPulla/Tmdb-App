import 'package:dio/dio.dart';
import 'package:tmdb_app_dio/config/constants/constants.dart';
import 'package:tmdb_app_dio/domain/datasource/movies_datasource.dart';
import 'package:tmdb_app_dio/domain/entities/movie.dart';
import 'package:tmdb_app_dio/infraestructure/mapers/movie_mapers.dart';
import 'package:tmdb_app_dio/infraestructure/models/movie_response.dart';

final Dio dio = Dio(
  BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Enviroment.tmdbApiKey,
      'language': 'es-MX',
    },
  ),
);

class MoviedbDataSourceApi extends MoviesDatasource {
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response =
        await dio.get('/movie/now_playing', queryParameters: {'page': page});

    final movieDBRespose = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDBRespose.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapers.movieDBToEnty(moviedb))
        .toList();

    return movies;
  }
}
