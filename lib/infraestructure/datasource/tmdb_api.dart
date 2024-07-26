import 'package:dio/dio.dart';
import 'package:tmdb_app_dio/config/constants/constants.dart';

class TmdbApi {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org',
      queryParameters: {
        'api_key': Enviroment.tmdbApiKey,
        'language': 'es-MX',
      },
    ),
  );

  Future getMovies() async {
    final response = await dio.get('/3/movie/now_playing');

    if (response.statusCode == 200) {
      print(response.data);
    } else {
      print('Algo Fallo en el camino');
    }
  }
}
