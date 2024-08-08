import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:go_router/go_router.dart';

import 'package:tmdb_app_dio/domain/entities/movie.dart';
import 'package:tmdb_app_dio/presentation/widgets/shared/ui_gradient.dart';

class MoviesSliderShow extends StatelessWidget {
  final List<Movie> movies;
  const MoviesSliderShow({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.6,
      width: double.infinity,
      child: Swiper(
        //viewportFraction: 0.8,
        scale: 0.9,
        autoplay: true,
        itemCount: movies.length,
        itemBuilder: (context, index) => _Slide(movie: movies[index]),
        pagination: SwiperPagination(
          margin: const EdgeInsets.only(top: 0),
          builder: DotSwiperPaginationBuilder(
            activeColor: colorTheme.primary,
            color: colorTheme.secondary,
          ),
        ),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    final themeText = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: GestureDetector(
        onTap: () => context.push('/home/0/movie/${movie.id}'),
        child: Stack(
          children: [
            ClipRRect(
              child: Image.network(
                height: double.infinity,
                width: double.infinity,
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
            const UiGradientTop(data: Alignment.topRight),
            Container(
              height: size.height * 0.6,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  colors: [
                    colorTheme.surface,
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            _DetailsSlider(
              colorTheme: colorTheme,
              movie: movie,
              themeText: themeText,
            )
          ],
        ),
      ),
    );
  }
}

class _DetailsSlider extends StatelessWidget {
  const _DetailsSlider({
    required this.colorTheme,
    required this.movie,
    required this.themeText,
  });

  final ColorScheme colorTheme;
  final Movie movie;
  final TextTheme themeText;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 25,
      bottom: 15,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: colorTheme.surface),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              child: Row(
                children: [
                  Icon(Icons.circle_rounded, size: 8, color: Colors.amber),
                  SizedBox(width: 5),
                  Text('Nuevo', style: TextStyle(fontSize: 10)),
                ],
              ),
            ),
          ),
          Text(
            movie.title,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 7, 5, 152),
                  Color.fromARGB(255, 0, 134, 243),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: Row(
                children: [
                  const Icon(Icons.play_arrow_rounded),
                  const SizedBox(width: 5),
                  Text(
                    'Ver Ahora',
                    style: themeText.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
