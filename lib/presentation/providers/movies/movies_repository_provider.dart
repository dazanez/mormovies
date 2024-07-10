import 'package:mormovies/infrasctructure/datasources/moviedb_datasource.dart';
import 'package:mormovies/infrasctructure/repositories/movies_ropository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'movies_repository_provider.g.dart';

// This provider is (or should be) inmutable
@riverpod
MoviesRepositoryImpl moviesRepositoryProvider(MoviesRepositoryProviderRef ref) {
  return MoviesRepositoryImpl(moviesDatasource: MoviedbDatasource());
}