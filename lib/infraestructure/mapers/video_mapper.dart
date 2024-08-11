import 'package:tmdb_app_dio/domain/entities/video.dart';
import 'package:tmdb_app_dio/infraestructure/models/moviedb/moviedb_videos_youtube.dart';

class VideoMapper {
  static Video videosById(VideoModel videoModel) => Video(
        name: videoModel.name,
        youtubeKey: videoModel.key,
        size: videoModel.size,
        type: videoModel.type,
        official: videoModel.official,
        publishedAt: videoModel.publishedAt,
        id: videoModel.id,
      );
}
