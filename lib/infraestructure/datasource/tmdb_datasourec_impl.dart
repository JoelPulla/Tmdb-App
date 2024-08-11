import 'package:dio/dio.dart';

import 'package:tmdb_app_dio/config/constants/constants.dart';
import 'package:tmdb_app_dio/domain/datasource/movies_datasource.dart';
import 'package:tmdb_app_dio/domain/entities/movie.dart';
import 'package:tmdb_app_dio/domain/entities/video.dart';
import 'package:tmdb_app_dio/infraestructure/mapers/movie_mapper.dart';
import 'package:tmdb_app_dio/infraestructure/mapers/video_mapper.dart';
import 'package:tmdb_app_dio/infraestructure/models/moviedb/movie_detail_response.dart';
import 'package:tmdb_app_dio/infraestructure/models/moviedb/movie_response.dart';
import 'package:tmdb_app_dio/infraestructure/models/moviedb/moviedb_videos_youtube.dart';

final Dio dio = Dio(
  BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Enviroment.tmdbApiKey,
      'language': 'es-MX',
    },
  ),
);

List<Movie> _jsonTomovie(Map<String, dynamic> json) {
  final movieDBRespose = MovieDbResponse.fromJson(json);

  final List<Movie> movies = movieDBRespose.results
      .where((moviedb) => moviedb.posterPath != 'no-poster')
      .map((moviedb) => MovieMapers.movieDBToEnty(moviedb))
      .toList();

  return movies;
}

class MoviedbDataSourceApi extends MoviesDatasource {
  //* NowPlaying
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response =
        await dio.get('/movie/now_playing', queryParameters: {'page': page});

    return _jsonTomovie(response.data);
  }

  //*Popular
  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get('/movie/popular', queryParameters: {
      'page': page,
    });

    return _jsonTomovie(response.data);
  }

  //*Up Coming
  @override
  Future<List<Movie>> getUpCpming({int page = 1}) async {
    final response = await dio.get('/movie/upcoming');

    return _jsonTomovie(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response =
        await dio.get('/movie/top_rated', queryParameters: {'page': page});

    return _jsonTomovie(response.data);
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('/movie/$id');
    if (response.statusCode != 200) throw Exception('Movie $id not found');

    final moviDetails = MovieDetailResponse.fromJson(response.data);
    final Movie movie = MovieMapers.movieDetailsToEntity(moviDetails);

    return movie;
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    if (query.isEmpty) return [];

    final response =
        await dio.get('/search/movie', queryParameters: {'query': query});

    return _jsonTomovie(response.data);
  }

  @override
  Future<List<Video>> getYoutubeVideosById(int movieId) async {
    final response = await dio.get('/movie/$movieId/videos');

    final movieDbVideosResponse = VideoResponse.fromJson(response.data);

    final videos = <Video>[];

    for (final movieDbVideo in movieDbVideosResponse.results) {
      if (movieDbVideo.site == 'YouTube') {
        final video = VideoMapper.videosById(movieDbVideo);
        videos.add(video);
      }
    }
    return videos;
  }
}
