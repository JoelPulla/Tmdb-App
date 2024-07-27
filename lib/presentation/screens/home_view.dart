import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tmdb_app_dio/presentation/providers/movies/movies_providers.dart';
import 'package:tmdb_app_dio/presentation/widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlaygiMovieProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlaygiMovieProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 25),
            //AppBarrDinamic
            const CustomAppbar(),

            //Slider
            MoviesSliderShow(movies: nowPlayingMovies)
          ],
        ),
      ),
    );
  }
}
