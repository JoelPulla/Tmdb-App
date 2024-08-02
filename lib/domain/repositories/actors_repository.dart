import 'package:tmdb_app_dio/domain/entities/actor.dart';

abstract class ActorsRepository{

  Future<List<Actor>> getActorsByMovie(String movieId);

  



}