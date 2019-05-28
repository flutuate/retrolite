import 'dart:core';
import 'dart:io';

import 'package:retrolite/retrolite.dart';
import 'package:retrolite/src/IApi.dart';

import 'Genre.dart';

class TmdbApi
extends IApi
{
  static final String _key = "";

  final String apiKey;

  final String language;

  final String region;

  TmdbApi(this.apiKey, {this.language='en-US', this.region='US'});

  @override
  Future<List<Genre>> genres()
    => client
        ..route = 'movie/upcoming'
        ..contentType = ContentType.json
        ..parameters = {
          'apk_key': apiKey,
          'language': language,
          'region': region,
          'page': 1
        }
        ..get<List<Genre>>();
  }
}