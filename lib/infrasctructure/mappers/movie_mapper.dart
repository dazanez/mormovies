import 'package:mormovies/domain/entities/movie.dart';
import 'package:mormovies/infrasctructure/models/moviedb/movie_from_moviedb.dart';

const notFoundImageUrl = 'https://m.media-amazon.com/images/I/719dcpoP1QL.jpg';

class MovieMapper {
  static Movie movieDbToEntity(MovieFromMoviedb moviedb) => Movie(
      adult: moviedb.adult,
      backdropPath: moviedb.backdropPath != ''
          ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
          : notFoundImageUrl,
      genreIds: moviedb.genreIds.map((id) => id.toString()).toList(),
      id: moviedb.id,
      originalLanguage: moviedb.originalLanguage,
      originalTitle: moviedb.originalTitle,
      overview: moviedb.overview,
      popularity: moviedb.popularity,
      posterPath: moviedb.posterPath != ''
          ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
          : 'no-poster',
      releaseDate: moviedb.releaseDate,
      title: moviedb.title,
      video: moviedb.video,
      voteAverage: moviedb.voteAverage,
      voteCount: moviedb.voteCount);
}
