import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mormovies/infrasctructure/datasources/moviedb_datasource.dart';
import 'package:mormovies/infrasctructure/repositories/movies_ropository_impl.dart';

// Este repositorio es inmutable
final moviesRepositoryProvider = Provider((ref) {
  return MoviesRepositoryImpl( moviesDatasource: MoviedbDatasource() );
});

