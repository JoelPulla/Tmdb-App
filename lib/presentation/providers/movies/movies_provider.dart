import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_app_dio/infraestructure/datasource/tmdb_datasourec_impl.dart';
import 'package:tmdb_app_dio/infraestructure/repositories/movie_repository_impl.dart';

final movieRepositoryProvider = Provider((ref) {
  //este repositorio es inmutable
  return MovieRepositoryImpl(MoviedbDataSourceApi());
});
