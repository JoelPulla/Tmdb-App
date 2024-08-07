import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tmdb_app_dio/domain/entities/movie.dart';
import 'package:tmdb_app_dio/presentation/delegates/search_movie_delegate.dart';

import '../../providers/providers.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeColor = Theme.of(context).colorScheme;
    final themeText = Theme.of(context).textTheme;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.movie_filter_outlined, color: themeColor.primary),
              const SizedBox(width: 5),
              Text('Movies App', style: themeText.titleMedium),
              const Spacer(),
              IconButton(
                onPressed: () async {
                  final searchedMovies = ref.read(serchedMoviesProvider);
                  final searchQuery = ref.read(searchQueryProvider);
                  showSearch<Movie?>(
                    query: searchQuery,
                    context: context,
                    delegate: SearchMovieDelegate(
                      initialMovie: searchedMovies,
                      searchMovies: ref
                          .read(serchedMoviesProvider.notifier)
                          .searchMoviesByQuery,
                    ),
                  ).then(
                    (movie) {
                      if (movie == null) return;
                      context.push('/home/0/movie/${movie.id}');
                    },
                  );
                },
                icon: const Icon(Icons.search),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
