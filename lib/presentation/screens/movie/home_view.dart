import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_app_dio/presentation/providers/providers.dart';

import 'package:tmdb_app_dio/presentation/widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  static const String name = 'home_view';

  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlaygiMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesPrivider.notifier).loadNextPage();
    ref.read(upCominMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLouding = ref.watch(initialLouderProvider);
    //* loading
    if (initialLouding) return const FullScreenLoading();

    final nowPlayingMovies = ref.watch(nowPlaygiMoviesProvider);
    final slideShowMovies = ref.watch(moviesSliderShowProvider);
    final popularMoviees = ref.watch(popularMoviesPrivider);
    final upComingMovies = ref.watch(upCominMoviesProvider);
    final topRatedMovies = ref.watch(topRatedProvider);

    return CustomScrollView(
      slivers: [
        //* AppBar
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
          ),
        ),

        //* Body
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [
                //* Slider
                MoviesSliderShow(movies: slideShowMovies),

                //* NowP laying Movies
                MovieHorizontalListview(
                  movie: nowPlayingMovies,
                  title: 'Now Playing',
                  subtitle: 'Sunday 20',
                  loadNextPage: () =>
                      ref.read(nowPlaygiMoviesProvider.notifier).loadNextPage(),
                ),

                //* Up Coming
                MovieHorizontalListview(
                  movie: upComingMovies,
                  title: 'Up Coming',
                  loadNextPage: () =>
                      ref.read(upCominMoviesProvider.notifier).loadNextPage(),
                ),

                //* Popular
                MovieHorizontalListview(
                  movie: popularMoviees,
                  title: 'Popular',
                  loadNextPage: () =>
                      ref.read(popularMoviesPrivider.notifier).loadNextPage(),
                ),

                //* Top Rated
                MovieHorizontalListview(
                  movie: topRatedMovies,
                  title: 'Top Rated',
                  loadNextPage: () =>
                      ref.read(topRatedProvider.notifier).loadNextPage(),
                ),

                //*Space
                const SizedBox(height: 25),
              ],
            );
          }, childCount: 1),
        ),
      ],
    );
  }
}
