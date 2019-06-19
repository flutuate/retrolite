import 'package:http/http.dart' as http;
import 'package:flutuate_api/flutuate_api.dart';

mixin ResponseBodyDeserializer
{
  Response parseResponseBody<TReturn>(http.Response httpResponse, {DeserializerFunction<TReturn> deserializer}) {
    String nameType = TReturn.toString().split(RegExp(r'\b')).first;
    String body = httpResponse.body.trim();
    if( nameType == 'int') {
      return new Response<int>(httpResponse, int.parse(body));
    }
    else if( nameType == 'bool' ) {
      return new Response<bool>(httpResponse, body.toLowerCase() == 'true');
    }
    else if( nameType == 'double' ) {
      return new Response<double>(httpResponse, double.parse(body));
    }
    else if( nameType == 'String') {
      return new Response<String>(httpResponse, body);
    }
    return new Response<TReturn>(httpResponse, deserializer(body));
  }
}