import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'movies_providers.dart';

import 'package:mormovies/domain/entities/movie.dart';

final moviesSlideshowProvider = Provider<List<Movie>>((ref) {
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

  if (nowPlayingMovies.isEmpty) return [];

  nowPlayingMovies.sort((movie, movie2) => movie.voteAverage.compareTo(movie2.voteAverage));

  return nowPlayingMovies.sublist(0, 6);
});
