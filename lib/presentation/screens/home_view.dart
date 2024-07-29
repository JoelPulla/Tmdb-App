import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_app_dio/presentation/providers/providers.dart';

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
    final slideShowMovies = ref.watch(moviesSliderShowProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //AppBarrDinamic
              const SizedBox(height: 25),
              const CustomAppbar(),

              //Slider
              MoviesSliderShow(movies: slideShowMovies),

              //GetNowPlayingMovies
              MovieHorizontalListview(
                movie: nowPlayingMovies,
                subtitle: 'Friday 20',
                title: 'New Movies In Cines',
                loadNextPage: ()=> ref.read(nowPlaygiMovieProvider.notifier).loadNextPage(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
