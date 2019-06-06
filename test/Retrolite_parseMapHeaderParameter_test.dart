import 'package:retrolite/retrolite.dart';
import 'package:test/test.dart';

void main()
{
  group('Retrolite.parseMapHeaderParameter tests', () {

    Retrolite retrolite;

    setUpAll(() {
      retrolite = Retrolite('http://localhost/');
    });

    test('Test passing a map with primitives parameters', () {
      Map parameter = {
        'name': 'João Smith',
        'age': 45,
        'version': 1.23,
        'bool': true
      };
      String parsedParameter = retrolite.parseMapHeaderParameter(parameter);

      expect(parsedParameter, 'name=João Smith,age=45,version=1.23,bool=true');
    });

    test('Test passing a map with primitive and list parameters', () {
      Map parameter = {
        'name': 'João Smith',
        'age': 45,
        'version': 1.23,
        'bool': true,
        'list': ['abc', 123, 4.56, true]
      };
      String parsedParameter = retrolite.parseMapHeaderParameter(parameter);

      expect(parsedParameter, 'name=João Smith,age=45,version=1.23,bool=true,list=abc,123,4.56,true');
    });

    test('Test passing a map with primitive, list and map parameters', () {
      Map parameter = {
        'name': 'João Smith',
        'age': 45,
        'version': 1.23,
        'bool': true,
        'list': ['abc', 123, 4.56, true],
        'map': {
          'v1': 1,
          'v2': 0.2,
          'v3': '3',
          'v4': true,
        }
      };
      String parsedParameter = retrolite.parseMapHeaderParameter(parameter);

      expect(parsedParameter, 'name=João Smith,age=45,version=1.23,bool=true,list=abc,123,4.56,true,map=v1=1,v2=0.2,v3=3,v4=true');
    });

  });
}

