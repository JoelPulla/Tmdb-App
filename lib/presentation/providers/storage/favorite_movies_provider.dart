import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_app_dio/domain/entities/movie.dart';
import 'package:tmdb_app_dio/domain/repositories/local_storage_repository.dart';
import 'package:tmdb_app_dio/presentation/providers/providers.dart';

final favoritesMoviesProvider =
    StateNotifierProvider<StorageMoviesNotifier, Map<int, Movie>>((ref) {
  final localStorageRepository = ref.watch(localStorageRepositoryprovider);

  return StorageMoviesNotifier(localStorageRepository: localStorageRepository);
});

class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  int page = 0;
  final LocalStorageRepository localStorageRepository;

  StorageMoviesNotifier({
    required this.localStorageRepository,
  }) : super({});

  Future<List<Movie>> loadNextPage() async {
    final movies =
        await localStorageRepository.loadMovies(offset: page * 10, limit: 20);
    page++;

    final tempMovies = <int, Movie>{};

    for (final movie in movies) {
      tempMovies[movie.id] = movie;
    }
    state = {...state, ...tempMovies};

    return movies;
  }

  //* Update Favorites *//

  Future<void> toggleFavorites(Movie movie) async {
    await localStorageRepository.toggleFavorites(movie);
    final bool isMovieInFavorites = state[movie.id] != null;

    if (isMovieInFavorites) {
      state.remove(movie.id);
      state = {...state};
    } else {
      state = {...state, movie.id: movie};
    }
  }
}
