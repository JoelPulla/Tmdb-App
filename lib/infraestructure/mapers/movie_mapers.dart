import 'package:tmdb_app_dio/domain/entities/movie.dart';
import 'package:tmdb_app_dio/infraestructure/models/moviedb_models.dart';

class MovieMapers {
  static Movie movieDBToEnty(MovieDbModels movieDb) => Movie(
        adult: movieDb.adult,
        backdropPath: (movieDb.backdropPath != '')
            ? 'https://image.tmdb.org/t/p/w500/${movieDb.backdropPath}'
            : 'https://upload.wikimedia.org/wikipedia/commons/a/a3/Image-not-found.png',
        genreIds: movieDb.genreIds.map((e) => e.toString()).toList(),
        id: movieDb.id,
        originalLanguage: movieDb.originalLanguage,
        originalTitle: movieDb.originalTitle,
        overview: movieDb.overview,
        popularity: movieDb.popularity,
        posterPath: (movieDb.posterPath != '')
            ? 'https://image.tmdb.org/t/p/w500/${movieDb.posterPath}'
            : 'no-poster',
        releaseDate: movieDb.releaseDate,
        title: movieDb.title,
        video: movieDb.video,
        voteAverage: movieDb.voteAverage,
        voteCount: movieDb.voteCount,
      );
}
