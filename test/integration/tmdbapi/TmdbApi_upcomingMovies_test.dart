import 'dart:core';
import 'package:retrolite/Secrets.dart';
import 'package:retrolite/retrolite.dart';
import 'package:flutuate_api/flutuate_api.dart' show Response;
import 'package:test/test.dart';

import '../../../example/retrolite_example.dart';
import '../../../example/tmdb/TmdbApi.dart';
import '../../../example/tmdb/UpcomingMovies.dart';

void main() {
  group('TmdbApi integration tests', () {
    Retrolite retrolite;
    TmdbApi api;

    setUpAll(() async {
      retrolite = Retrolite('https://api.themoviedb.org/3/',
          httpClient: newUnsafeHttpClient());

      Secrets secrets = await Secrets.loadFromFile();

      api = retrolite.register<TmdbApi>(new TmdbApi(secrets['tmdb_token']));
    });

    test('Get upcoming movies', () async {
      Response<UpcomingMovies> upcomingMovies = await api.upcomingMovies();
      expect(upcomingMovies.value.movies, isNotEmpty);
    });
  });
}
