import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:retrolite/retrolite.dart';

import 'tmdb/TmdbApi.dart';

main() {
  Retrolite retrolite = Retrolite(
    baseUrl: 'https://api.themoviedb.org/3/',
    client: newHttpClient(),
  );

  //var api = new TmdbApi(retrolite);

  var api = retrolite.create<TmdbApi>( new TmdbApi() );
}

/// Returns an instance of the default http client.
http.BaseClient newHttpClient() {
  return http.Client();
}

/// Returns an http client that ignores unsafe SSL certificates.
http.BaseClient newUnsafeHttpClient() {
  final bool trustSelfSigned = true;
  HttpClient httpClient = new HttpClient()
    ..badCertificateCallback = ((X509Certificate cert, String host, int port) => trustSelfSigned);
  return new IOClient(httpClient);
}

