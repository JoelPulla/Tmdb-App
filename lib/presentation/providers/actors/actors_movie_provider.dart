import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_app_dio/domain/entities/actor.dart';
import 'package:tmdb_app_dio/presentation/providers/actors/actors_repository_provider.dart';

//IMPL PROVIDER
final actorsByMovieProvider =
    StateNotifierProvider<ActorsMovieNotifier, Map<String, List<Actor>>>((ref) {
  final actorRepository = ref.watch(actorsRepositoryProvider);

  return ActorsMovieNotifier(getActors: actorRepository.getActorsByMovie);
});

//* Comprender Mejor *//
typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

class ActorsMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallback getActors;

  ActorsMovieNotifier({required this.getActors}) : super({});

  //*  Funcion  *//
  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return;

    final List<Actor> actor = await getActors(movieId);
    state = {...state, movieId: actor};
  }
}


//* *//