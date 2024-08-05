import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:go_router/go_router.dart';

import 'package:tmdb_app_dio/domain/entities/movie.dart';

class MoviesSliderShow extends StatelessWidget {
  final List<Movie> movies;
  const MoviesSliderShow({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: 210,
      width: double.infinity,
      child: Swiper(
        pagination: SwiperPagination(
          margin: const EdgeInsets.only(top: 0),
          builder: DotSwiperPaginationBuilder(
            activeColor: colorTheme.primary,
            color: colorTheme.secondary,
          ),
        ),
        viewportFraction: 0.8,
        scale: 0.9,
        autoplay: true,
        itemCount: movies.length,
        itemBuilder: (context, index) => _Slide(movie: movies[index]),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black45, blurRadius: 10, offset: Offset(0, 10))
            ],
          ),
          child: GestureDetector(
            onTap: () => context.push('/home/0/movie/${movie.id}'),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.backdropPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const DecoratedBox(
                      decoration: BoxDecoration(color: Colors.black45),
                    );
                  }
                  return FadeIn(child: child);
                },
              ),
            ),
          )),
    );
  }
}
