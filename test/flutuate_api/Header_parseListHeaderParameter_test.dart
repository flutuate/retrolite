import 'package:retrolite/flutuate_api.dart';
import 'package:test/test.dart';

void main() {
  group('Header.parseListMapHeaderParameter tests', () {
    test('Test passing a list with primitives parameters', () {
      List parameter = ['João Smith', 45, 1.23, true];
      final header = Headers.custom('custom', value: '', parameters: parameter);

      String parsedParameter = header.parseListHeaderParameter(parameter);

      expect(parsedParameter, 'João Smith,45,1.23,true');
    });

    test('Test passing a list with primitive and list parameters', () {
      List parameter = [
        'João Smith',
        45,
        1.23,
        true,
        ['abc', 123, 4.56, true]
      ];

      final header = Headers.custom('custom', value: '', parameters: parameter);

      String parsedParameter = header.parseListHeaderParameter(parameter);

      expect(parsedParameter, 'João Smith,45,1.23,true,abc,123,4.56,true');
    });

    test('Test passing a list with primitive, list and map parameters', () {
      List parameter = [
        'João Smith',
        45,
        1.23,
        ['abc', 123, 4.56, true],
        {
          'v1': 1,
          'v2': 0.2,
          'v3': '3',
          'v4': true,
        }
      ];

      final header = Headers.custom('custom', value: '', parameters: parameter);

      String parsedParameter = header.parseListHeaderParameter(parameter);

      expect(parsedParameter,
          'João Smith,45,1.23,abc,123,4.56,true,v1=1,v2=0.2,v3=3,v4=true');
    });
  });
}
