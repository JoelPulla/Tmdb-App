import 'package:tmdb_app_dio/domain/datasource/actors_datasource.dart';
import 'package:tmdb_app_dio/domain/entities/actor.dart';
import 'package:tmdb_app_dio/domain/repositories/actors_repository.dart';

//* REVISAR PARA COMPRENDER MEJOR *//
class ActorRespositoryImpl extends ActorsRepository {
  final ActorsDatasource datasource;
  ActorRespositoryImpl(this.datasource);

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    return datasource.getActorsByMovie(movieId);
  }
}
