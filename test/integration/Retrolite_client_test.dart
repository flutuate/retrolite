import 'dart:core';

import 'package:retrolite/Secrets.dart';
import 'package:retrolite/flutuate_api.dart';
import 'package:retrolite/retrolite.dart';
import 'package:test/test.dart';

import '../../example/retrolite_example.dart';
import '../../example/tmdb/MovieGenres.dart';
import '../../example/tmdb/TmdbApi.dart';

void main() {
  group('HTTP client provider to Retrolite tests', () {
    Retrolite retrolite;
    TmdbApi api;

    setUpAll(() async {
      retrolite = Retrolite('https://api.themoviedb.org/3/',
          httpClientCreator: newUnsafeHttpClient);

      Secrets secrets = await Secrets.loadFromFile();

      api = retrolite.register<TmdbApi>(new TmdbApi(secrets['tmdb_token']));
    });

    test('Get movie genres from TmdbApi', () async {
      Response<MovieGenres> genres = await api.genresForMovies();
      expect(genres.value.genres, isNotEmpty);

      // Request again to check if client was not closed.
      genres = await api.genresForMovies();
      expect(genres.value.genres, isNotEmpty);
    });
  });
}
