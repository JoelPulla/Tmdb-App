//* PROVIDER INMUTABLE *//
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_app_dio/infraestructure/datasource/tmdb_datasource_impl.dart';
import 'package:tmdb_app_dio/infraestructure/repositories/actor_respository_impl.dart';

final actorsRepositoryProvider = Provider((ref) {
  return ActorRespositoryImpl(ActorsDatasourceImpl());
});
