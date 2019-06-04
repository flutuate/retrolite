import 'dart:core';
import 'dart:io';

import 'package:retrolite/flutuate_http.dart';

import 'Genre.dart';

class TmdbApi
extends IApi
{
  final String apiKey;

  final String language;

  final String region;

  TmdbApi(this.apiKey, {this.language='en-US', this.region='US'});

  /// Get the list of official genres for movies.
  Future<List<Genre>> genresForMovies()
    => client.get<List<Genre>>(
        'genre/movie/list',
        contentType: ContentType.json,
        queryParameters: {
          'api_key': apiKey,
          'language': language,
          'region': region,
          'page': 1
        } );
}

