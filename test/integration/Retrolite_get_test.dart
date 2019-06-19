import 'dart:core';
import 'package:retrolite/Secrets.dart';
import 'package:retrolite/retrolite.dart';
import 'package:flutuate_api/flutuate_api.dart';
import 'package:test/test.dart';

import '../../example/retrolite_example.dart';
import '../../example/tmdb/MovieGenres.dart';
import '../../example/tmdb/TmdbApi.dart';

void main()
{
  group('Retrolite.get integration tests', () {

    Retrolite retroliteTmdbApi;
    TmdbApi api;

    setUpAll(() async {

      retroliteTmdbApi = Retrolite(
          'https://api.themoviedb.org/3/',
          httpClient: newUnsafeHttpClient()
      );

      Secrets secrets = await Secrets.loadFromFile();

      api = retroliteTmdbApi.register<TmdbApi>(
        new TmdbApi(secrets['tmdb_token'])
      );
    });

    test('Get movie genres from TmdbApi', () async {
      Response<MovieGenres> genres = await api.genresForMovies();
      expect(genres.value.genres, isNotEmpty);
    });

  });
}
