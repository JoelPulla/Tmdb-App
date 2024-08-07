import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_app_dio/infraestructure/datasource/isar_datasource_localstorage_impl.dart';
import 'package:tmdb_app_dio/infraestructure/repositories/local_storage_repository_impl.dart';

final localStorageRepositoryprovider = Provider((ref) {
  return LocalStorageRepositoryImpl(IsartDataSourceImpl());
});
