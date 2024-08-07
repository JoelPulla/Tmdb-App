import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_app_dio/presentation/providers/providers.dart';
import 'package:tmdb_app_dio/presentation/widgets/widgets.dart';

class FavoritesView extends ConsumerStatefulWidget {
  static const name = 'favorites';
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  bool isLastPage = false;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;
    isLoading = true;

    final movies =
        await ref.read(favoritesMoviesProvider.notifier).loadNextPage();
    isLoading = false;

    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final favotiesMovies = ref.watch(favoritesMoviesProvider).values.toList();

    if (favotiesMovies.isEmpty) {
      return const IsEmtyData(
        iconData: Icons.heart_broken_outlined,
        description: 'No tienes peliculas favoritas',
        textButton: 'Empieza a buscar',
      );
    }

    return Scaffold(
      body: MovieMasonry(
        loadNextPage: loadNextPage,
        movies: favotiesMovies,
      ),
    );
  }
}
