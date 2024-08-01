import 'package:dio/dio.dart';
import 'package:tmdb_app_dio/config/constants/constants.dart';
import 'package:tmdb_app_dio/domain/datasource/actors_datasource.dart';
import 'package:tmdb_app_dio/domain/entities/actor.dart';
import 'package:tmdb_app_dio/infraestructure/mapers/actor_mapper.dart';
import 'package:tmdb_app_dio/infraestructure/models/moviedb/actor_response.dart';

class ActorsDatasourceImpl extends ActorsDatasource {
  final dio = Dio(
      BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
    'api_key': Enviroment.tmdbApiKey,
    'language': 'es-MX',
  }));

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');

    final actorsResponse = ActorsRespose.fromJson(response.data);

    //* REVISAR PARA COMPRENDER MEJOR *//
    List<Actor> actors = actorsResponse.cast
        .map((cast) => ActorMapper.actorToEntity(cast))
        .toList();

    return actors;
  }
}
