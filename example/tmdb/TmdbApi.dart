import 'dart:core';
import 'dart:io';

import 'package:retrolite/flutuate_http.dart';
import 'package:retrolite/src/http/Response.dart';

import 'MovieGenres.dart';

class TmdbApi
extends IApi
{
  final String apiKey;

  final String language;

  final String region;

  TmdbApi(this.apiKey, {this.language='en-US', this.region='US'});

  /// Get the list of official genres for movies.
  Future<Response<MovieGenres>> genresForMovies()
    => client.get<MovieGenres>(
        'genre/movie/list',
        deserializer: MovieGenres.deserialize,
        contentType: ContentType.json,
        queryParameters: {
          'api_key': apiKey,
          'language': language,
          'region': region,
          'page': 1
        } );
/*
  /// Get a list of upcoming movies in theatres.
  Future<List<Movie>> upcomingMovies()
  => client.get<List<Genre>>(
      '/movie/upcoming',
      parser: genresFromJson,
      contentType: ContentType.json,
      queryParameters: {
        'api_key': apiKey,
        'language': language,
        'region': region,
        'page': 1
      } );*/
}

