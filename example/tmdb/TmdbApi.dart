import 'dart:convert';
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

  @override
  Future<List<Genre>> genres()
    => client.get<List<Genre>>(
        'movie/upcoming',
        contentType: ContentType.json,
        headers: [
          //'unuseless': HeaderValue('any', {'charset': utf8.name})
          Headers.custom(
              'unuseless',
              value:'any',
              parameters: [
                {'charset': utf8.name},
                'text/html'
              ]
          )
        ],
        queryParameters: {
          'api_key': apiKey,
          'language': language,
          'region': region,
          'page': 1
        } );
}

