import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tmdb_app_dio/domain/datasource/local_storage_datasource.dart';
import 'package:tmdb_app_dio/domain/entities/movie.dart';

//* revisar para comprender *//

class IsartDataSourceImpl extends LocalStorageDatasource {
  late Future<Isar> db;

  IsartDataSourceImpl() {
    db = onpenDB();
  }

  Future<Isar> onpenDB() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([MovieSchema],
          inspector: true, directory: dir.path);
    }
    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    final isar = await db;

    final Movie? isMovieFavorite =
        await isar.movies.filter().idEqualTo(movieId).findFirst();

    return isMovieFavorite != null;
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) async {
    final isart = await db;

    return isart.movies.where().offset(offset).limit(limit).findAll();
  }

  @override
  Future<void> toggleFavorites(Movie movie) async {
    final isar = await db;

    final favoriteMovie =
        await isar.movies.filter().idEqualTo(movie.id).findFirst();

    if (favoriteMovie != null) {
      //Borrar
      isar.writeTxnSync(() => isar.movies.deleteSync(favoriteMovie.isartid!));
      return;
    }

    //Insertar
    isar.writeTxnSync(() => isar.movies.putSync(movie));
  }
}
