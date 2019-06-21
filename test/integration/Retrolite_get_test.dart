import 'dart:core';

import 'package:retrolite/Secrets.dart';
import 'package:retrolite/flutuate_api.dart' hide isNull, isNotNull;
import 'package:retrolite/retrolite.dart' hide isNull, isNotNull;
import 'package:test/test.dart';

import '../../example/retrolite_example.dart';
import '../../example/tmdb/MovieGenres.dart';
import '../../example/tmdb/TmdbApi.dart';

void main() {
  group('Retrolite.get integration tests', () {
    Retrolite retroliteTmdbApi;
    TmdbApi api;

    setUpAll(() async {
      retroliteTmdbApi = Retrolite('https://api.themoviedb.org/3/',
          httpClientCreator: newUnsafeHttpClient);

      Secrets secrets = await Secrets.loadFromFile();

      api = retroliteTmdbApi
          .register<TmdbApi>(new TmdbApi(secrets['tmdb_token']));
    });

    test('Get movie genres from TmdbApi', () async {
      Response<MovieGenres> genres = await api.genresForMovies();
      expect(genres.body, isNotNull);
      expect(genres.body.genres, isNotEmpty);
    });

    test('Get movie genres from TmdbApi with invalid token', () async {
      api = retroliteTmdbApi.register<TmdbApi>(new TmdbApi('invalid token'));
      Response<MovieGenres> genres = await api.genresForMovies();
      expect(genres.body, isNull);
    });
  });
}
