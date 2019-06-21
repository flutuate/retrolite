import 'package:http/http.dart' as http;
import 'package:retrolite/flutuate_api.dart';

class ResponseBuilder<T> {
  static Response build<T>(http.Response httpResponse,
      {DeserializerFunction<T> deserializer}) {
    String nameType = T.toString().split(RegExp(r'\b')).first;
    String responseBody = httpResponse.body.trim();

    switch (nameType) {
      case 'int':
        return Response<int>(
            httpResponse, buildInt(httpResponse, responseBody));
      case 'bool':
        return Response<bool>(
            httpResponse, buildBool(httpResponse, responseBody));
      case 'double':
        return Response<double>(
            httpResponse, buildDouble(httpResponse, responseBody));
      case 'num':
        return Response<num>(
            httpResponse, buildNum(httpResponse, responseBody));
      case 'String':
        return Response<String>(httpResponse, responseBody);
      case 'void':
        return Response<void>(httpResponse, null);
      default:
        return Response<T>(httpResponse,
            buildByDeserializer<T>(httpResponse, responseBody, deserializer));
    }
  }

  static bool isSuccessful(int code) => code >= 200 && code < 300;

  static int buildInt(http.Response httpResponse, String responseBody) {
    if (!isSuccessful(httpResponse.statusCode)) return null;
    return int.tryParse(responseBody);
  }

  static bool buildBool(http.Response httpResponse, String responseBody) {
    if (!isSuccessful(httpResponse.statusCode)) return null;
    return responseBody.toLowerCase() == 'true';
  }

  static double buildDouble(http.Response httpResponse, String responseBody) {
    if (!isSuccessful(httpResponse.statusCode)) return null;
    return double.tryParse(responseBody);
  }

  static num buildNum(http.Response httpResponse, String responseBody) {
    if (!isSuccessful(httpResponse.statusCode)) return null;
    return num.tryParse(responseBody);
  }

  static T buildByDeserializer<T>(http.Response httpResponse,
      String responseBody, DeserializerFunction<T> deserializer) {
    if (!isSuccessful(httpResponse.statusCode)) return null;
    return deserializer(responseBody);
  }
}
