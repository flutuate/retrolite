import 'package:http/http.dart' as http;

class Response<T> extends DelegatingHttpResponse {
  final T body;

  Response(http.Response httpResponse, this.body) : super(httpResponse);

  bool get isSuccessful => super.statusCode >= 200 && super.statusCode < 300;
}

class DelegatingHttpResponse {
  http.Response _response;

  DelegatingHttpResponse(this._response);

  String get rawBody => _response.body;

  /// The (frozen) request that triggered this response.
  http.BaseRequest get request => _response.request;

  /// The status code of the response.
  int get statusCode => _response.statusCode;

  /// The reason phrase associated with the status code.
  String get reasonPhrase => _response.reasonPhrase;

  /// The size of the response body, in bytes.
  ///
  /// If the size of the request is not known in advance, this is `null`.
  int get contentLength => _response.contentLength;

  /// The headers for this response.
  Map<String, String> get headers => _response.headers;

  /// Whether this response is a redirect.
  bool get isRedirect => _response.isRedirect;

  /// Whether the server requested that a persistent connection be maintained.
  bool get persistentConnection => _response.persistentConnection;
}
