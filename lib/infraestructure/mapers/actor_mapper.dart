import 'package:tmdb_app_dio/domain/entities/actor.dart';
import 'package:tmdb_app_dio/infraestructure/models/moviedb/actor_model.dart';

class ActorMapper {
  static Actor actorToEntity(ActorsModel actorModel) => Actor(
        id: actorModel.id,
        name: actorModel.name,
        profilePath: actorModel.profilePath != null
            ? 'https://image.tmdb.org/t/p/w500/${actorModel.profilePath}'
            : 'https://upload.wikimedia.org/wikipedia/commons/a/a3/Image-not-found.png',
        character: actorModel.character,
      );
}
