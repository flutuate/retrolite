import 'package:http/http.dart' as http;

bool isNull(Object obj) => obj == null;

bool isNotNull(Object obj) => !isNull(obj);

bool isNullOrEmpty(dynamic obj) =>
  obj == null || ((obj is String || obj is List || obj is Map) && obj.isEmpty);

Type typeof<T>() => T;

/// Returns an instance of the default http client.
http.BaseClient newDefaultHttpClient() =>
  http.Client();

