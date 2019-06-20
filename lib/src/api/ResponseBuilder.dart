import 'package:http/http.dart' as http;
import 'package:retrolite/flutuate_api.dart';

class ResponseBuilder<T>
{
  static Response build<T>(http.Response httpResponse,
      {DeserializerFunction<T> deserializer}) {
    String nameType = T.toString().split(RegExp(r'\b')).first;
    String body = httpResponse.body.trim();

    switch(nameType){
      case 'int':
        return new Response<int>(httpResponse, int.parse(body));
      case 'bool':
        return new Response<bool>(httpResponse, body.toLowerCase() == 'true');
      case 'double':
        return new Response<double>(httpResponse, double.parse(body));
      case 'String':
        return new Response<String>(httpResponse, body);
      case 'void':
        return new Response<void>(httpResponse, null);
      default:
        return new Response<T>(httpResponse, deserializer(body));
    }
  }
}
