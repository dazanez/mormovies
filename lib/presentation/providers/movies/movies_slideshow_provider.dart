import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'movies_providers.dart';

import 'package:mormovies/domain/entities/movie.dart';

final moviesSlideshowProvider = Provider<List<Movie>>((ref) {
  final List<Movie> nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
  late final List<Movie> bestNowPlayingMovies;
  if (nowPlayingMovies.isEmpty) return [];

  bestNowPlayingMovies = [...nowPlayingMovies]..sort((movie, movie2) => movie2.voteAverage.compareTo(movie.voteAverage));

  return bestNowPlayingMovies.sublist(0, 6);
});
