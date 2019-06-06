import 'package:http/http.dart' as http;

//typedef T ParserFunction<T>(Map<String,dynamic> json);
typedef T DeserializerFunction<T>(String body);

bool isNull(Object obj) => obj == null;

bool isNotNull(Object obj) => !isNull(obj);

bool isNullOrEmpty(dynamic obj) =>
    obj == null || ((obj is String || obj is List || obj is Map) && obj.isEmpty);

bool isPrimitiveType(Type type) =>
    ['bool','int','double','String'].contains(type.toString().split(RegExp(r'\b')).first);

bool isMap(Type type) => isType(type, 'Map');

bool isList(Type type) => isType(type, 'List');

bool isString(Type type) => isType(type, 'String');

bool isDouble(Type type) => isType(type, 'double');

bool isInt(Type type) => isType(type, 'int');

bool isBool(Type type) => isType(type, 'bool');

bool isType(Type type, String typename) =>
    type.toString().split(RegExp(r'\b')).first == typename;

Type typeof<T>() => T;

/// Returns an instance of the default http client.
http.BaseClient newDefaultHttpClient() =>
  http.Client();

