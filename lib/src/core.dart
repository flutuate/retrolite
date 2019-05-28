import 'package:http/http.dart' as http;

bool isValid(Object obj) => obj != null;

bool isInvalid(Object obj) => !isValid(obj);

Type typeof<T>() => T;

@deprecated
http.Client newLoggingClient([http.Client client]) =>
  new http.Client();

