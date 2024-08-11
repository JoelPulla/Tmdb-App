import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_app_dio/domain/entities/video.dart';
import 'package:tmdb_app_dio/presentation/providers/providers.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

//* Create Provider *//

final FutureProviderFamily<List<Video>, int> videosFromMovieProvider =
    FutureProvider.family((ref, int movieId) {
  //*//
  final movieRepository = ref.watch(movieRepositoryProvider);
  return movieRepository.getYoutubeVideosById(movieId);
});

class VideosFromMovie extends ConsumerWidget {
  final int movieId;
  const VideosFromMovie({required this.movieId, super.key});

  @override
  Widget build(BuildContext context, ref) {
    final moviesFromVideo = ref.watch(videosFromMovieProvider(movieId));

    //* Condicion*//

    return moviesFromVideo.when(
      data: (videos) => _VideosList(videos: videos),
      error: (_, __) => const Center(child: Text('No se pudo cargar videos')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class _VideosList extends StatelessWidget {
  final List<Video> videos;
  const _VideosList({required this.videos});

  @override
  Widget build(BuildContext context) {
    if (videos.isEmpty) {
      return const SizedBox(
        child: Text('No hay datos para mostrar'),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ignore: prefer_const_constructors
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: const Text(
            'Videos',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),

        //* Aunque tengo varios videos, sólo quiero mostrar el primero
        _YouTubeVideoPlayer(
            youtubeId: videos.first.youtubeKey, name: videos.first.name)

        //* Si se desean mostrar todos los videos
        // ...videos.map(
        //   (video) => _YouTubeVideoPlayer(youtubeId: videos.first.youtubeKey, name: video.name)
        // ).toList()
      ],
    );
  }
}

class _YouTubeVideoPlayer extends StatefulWidget {
  final String youtubeId;
  final String name;

  const _YouTubeVideoPlayer({required this.youtubeId, required this.name});

  @override
  State<_YouTubeVideoPlayer> createState() => __YouTubeVideoPlayerState();
}

class __YouTubeVideoPlayerState extends State<_YouTubeVideoPlayer> {
  late YoutubePlayerController _controller;
  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: widget.youtubeId,
      flags: const YoutubePlayerFlags(
        hideThumbnail: true,
        showLiveFullscreenButton: false,
        mute: false,
        autoPlay: false,
        disableDragSeek: true,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
      ),
    );

    @override
    void dispose() {
      _controller.dispose();
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(widget.name), YoutubePlayer(controller: _controller)],
      ),
    );
  }
}
