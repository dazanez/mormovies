import 'package:dio/dio.dart';
import 'package:mormovies/config/constants/environment.dart';
import 'package:mormovies/domain/datasources/movies_datasource.dart';
import 'package:mormovies/domain/entities/movie.dart';
import 'package:mormovies/infrasctructure/mappers/movie_mapper.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(
    BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
      'api_key': Environment.theMovieDbKey,
      'language': 'en-US'
    }),
  );

  Future<List<Movie>> _getMoviesFromPath(String path,
      {Map<String, dynamic>? queryParameters}) async {
    final response = await dio.get(path, queryParameters: queryParameters);
    return MovieMapper.moviedbJsonToMovieEntityList(moviedbJson: response.data);
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async =>
      await _getMoviesFromPath(
        '/movie/now_playing',
        queryParameters: {'page': page},
      );

  @override
  Future<List<Movie>> getPopular({int page = 1}) async =>
      await _getMoviesFromPath(
        '/movie/popular',
        queryParameters: {'page': page},
      );

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async => await _getMoviesFromPath(
        '/movie/top_rated',
        queryParameters: {'page': page},
      );

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async => await _getMoviesFromPath(
        '/movie/upcoming',
        queryParameters: {'page': page},
      );
}
