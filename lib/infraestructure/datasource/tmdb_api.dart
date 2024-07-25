import 'package:dio/dio.dart';

class TmdbApi {

  final  Dio dio = Dio(
    BaseOptions(
      baseUrl: ''
    )
  );



  Future getMovies() async {}
}
