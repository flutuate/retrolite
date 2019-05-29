import 'package:http/http.dart' as http;

bool isValid(Object obj) => obj != null;

bool isInvalid(Object obj) => !isValid(obj);

Type typeof<T>() => T;

/// Returns an instance of the default http client.
http.BaseClient newDefaultHttpClient() =>
  http.Client();

