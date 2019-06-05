import 'dart:core';
import 'dart:io';
import 'package:retrolite/retrolite.dart';
import 'package:test/test.dart';

import '../../example/retrolite_example.dart';
import '../../example/tmdb/Genre.dart';
import '../../example/tmdb/TmdbApi.dart';

import 'package:retrolite/flutuate_http.dart';

void main()
{
  group('Retrolite.get integration tests', () {

    Retrolite retroliteSimpleApi, retroliteTmdbApi;
    SimpleApi simpleApi;
    TmdbApi tmdbApi;

    setUpAll(() {

      retroliteSimpleApi = Retrolite(
        //'https://api.themoviedb.org/3/',
        //httpClient: newHttpClient(), //newUnsafeHttpClient()
        'https://173.247.238.167:3001',
        httpClient: newUnsafeHttpClient()
      );

      simpleApi = retroliteSimpleApi.register<SimpleApi>( new SimpleApi() );

      retroliteTmdbApi = Retrolite(
          'https://api.themoviedb.org/3/',
          httpClient: newUnsafeHttpClient()
      );

      tmdbApi = retroliteTmdbApi.register<TmdbApi>( new TmdbApi('1f54bd990f1cdfb230adb312546d765d') );

    });

//    test('Get token from SimpleApi', () async {
//      String token = await simpleApi.getToken();
//      expect(token, isNotEmpty);
//    });

    test('Get movie genres from TmdbApi', () async {
      List<Genre> genres = await tmdbApi.genresForMovies();
      expect(genres, isNotEmpty);
    });

  });
}

class SimpleApi extends IApi
{
  Future<String> getToken()
  => client.get<String>(
    '/',
    contentType: ContentType.text,
  );
}

