import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_app_dio/domain/entities/movie.dart';

class MovieHorizontalListview extends StatelessWidget {
  final List<Movie> movie;
  final String? title;
  final String? subtitle;
  final VoidCallback? loadNextPage;

  const MovieHorizontalListview({
    super.key,
    required this.movie,
    this.title,
    this.subtitle,
    this.loadNextPage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          //title
          if (title != null || subtitle != null)
            _Title(title: title, subtitle: subtitle),

          //ListView
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movie.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (contex, index) {
                return _Slide(movie: movie[index]);
              },
            ),
          )
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final themeText = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        //* Image
        children: [
          //* Title
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                width: 150,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return FadeInRight(child: child);
                },
              ),
            ),
          ),
          const SizedBox(height: 5),

          //* Title
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              style: themeText.titleSmall,
              maxLines: 2,
            ),
          ),

          //*Vote
          Row(
            children: [
              const Icon(
                Icons.star_half_rounded,
                color: Colors.amber,
              ),
              Text(
                '${movie.voteAverage}',
                style: themeText.bodyMedium?.copyWith(color: Colors.amber),
              ),
              Text(movie.popularity.toString(), style: themeText.bodyMedium)
            ],
          )
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    required this.title,
    required this.subtitle,
  });

  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final themeText = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (title != null)
            Text(
              title!,
              style: themeText.titleMedium,
            ),
          const Spacer(),
          if (subtitle != null)
            FilledButton.tonal(
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: () {},
              child: Text(
                subtitle!,
              ),
            )
        ],
      ),
    );
  }
}
