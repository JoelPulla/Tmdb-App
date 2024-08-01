import 'package:tmdb_app_dio/infraestructure/models/moviedb/actor_model.dart';

class ActorsRespose {
  final int id;
  final List<ActorsModel> cast;

  ActorsRespose({
    required this.id,
    required this.cast,
  });

  factory ActorsRespose.fromJson(Map<String, dynamic> json) => ActorsRespose(
        id: json["id"],
        cast: List<ActorsModel>.from(
            json["cast"].map((x) => ActorsModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
      };
}
