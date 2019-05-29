import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:retrolite/flutuate_http.dart';
import 'package:retrolite/retrolite.dart';

import 'tmdb/TmdbApi.dart';

main() {
  Retrolite retrolite = Retrolite(
    'https://api.themoviedb.org/3/',
    httpClient: newHttpClient(),
  );

  TmdbApi api = retrolite.register<TmdbApi>( new TmdbApi('1f54bd990f1cdfb230adb312546d765d') );
  //TODO
}

/// Returns an instance of the default http client.
http.BaseClient newHttpClient() {
  return newDefaultHttpClient();
}

/// Returns an http client that ignores unsafe SSL certificates.
http.BaseClient newUnsafeHttpClient() {
  final bool trustSelfSigned = true;
  HttpClient httpClient = new HttpClient()
    ..badCertificateCallback = ((X509Certificate cert, String host, int port) => trustSelfSigned);
  return new IOClient(httpClient);
}

