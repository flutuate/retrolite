import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:retrolite/Secrets.dart';
import 'package:retrolite/flutuate_http.dart';
import 'package:retrolite/retrolite.dart';
import 'package:flutuate_api/flutuate_api.dart';

import 'reqres/RegisterContent.dart';
import 'reqres/ReqResApi.dart';
import 'tmdb/TmdbApi.dart';

main() async {
  await listMoviesGenresFromTmdbApi();

  await registerFromReqResApi();
}

void listMoviesGenresFromTmdbApi() async {
  print('Calling TMDB api...\n');

  Retrolite retrolite = Retrolite(
    'https://api.themoviedb.org/3/',
    httpClient: newHttpClient(),
  );

  Secrets secrets = await Secrets.loadFromFile();

  if (secrets.containsKey('tmdb_token')) {
    TmdbApi api =
        retrolite.register<TmdbApi>(new TmdbApi(secrets['tmdb_token']));

    await api.genresForMovies().then((response) {
      for (var genre in response.value.genres) {
        print(genre.toJson());
      }
    });
  } else {
    print(
        'Please, specifies you TMDB API token in "resources/secrets.json" file.');
  }
  print('');
}

void registerFromReqResApi() async {
  print('Calling REQ|RES api...\n');

  Retrolite retrolite = Retrolite(
    'https://reqres.in',
    httpClient: newUnsafeHttpClient(),
  );

  ReqResApi api = retrolite.register<ReqResApi>(new ReqResApi());

  RegisterContent content = new RegisterContent('eve.holt@reqres.in', 'pistol');

  await api.register(content).then((response) {
    print(response.value.toJson());
  });
  print('');
}

/// Returns an instance of the default http client.
http.BaseClient newHttpClient() {
  return newDefaultHttpClient();
}

/// Returns an http client that ignores unsafe SSL certificates.
http.BaseClient newUnsafeHttpClient() {
  final bool trustSelfSigned = true;
  HttpClient httpClient = new HttpClient()
    ..badCertificateCallback =
        ((X509Certificate cert, String host, int port) => trustSelfSigned);
  return new IOClient(httpClient);
}
