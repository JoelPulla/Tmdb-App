class Video {
  final String name;
  final String youtubeKey;
  final int size;
  final String type;
  final bool official;
  final DateTime publishedAt;
  final String id;

  Video({
    required this.name,
    required this.youtubeKey,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        name: json["name"],
        youtubeKey: json["key"],
        size: json["size"],
        type: json["type"],
        official: json["official"],
        publishedAt: DateTime.parse(json["published_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "key": youtubeKey,
        "size": size,
        "type": type,
        "official": official,
        "published_at": publishedAt.toIso8601String(),
        "id": id,
      };
}
