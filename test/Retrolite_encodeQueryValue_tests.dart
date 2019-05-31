import 'package:retrolite/retrolite.dart';
import 'package:test/test.dart';

void main() {
  group('Retrolite.encodeQueryValue tests', () {

    var retrolite;

    setUp(() {
      retrolite = Retrolite('http://localhost:8080');
    });

    test('Parameter null', () {
      var parameters = retrolite.encodeQueryValue(null);
      expect(parameters, isEmpty);
    });

    test('Empty string', () {
      var parameters = retrolite.encodeQueryValue('');
      expect(parameters, isEmpty);
    });

    test('Empty list', () {
      var parameters = retrolite.encodeQueryValue([]);
      expect(parameters, '%5B%5D');
    });

    test('Empty map', () {
      var parameters = retrolite.encodeQueryValue({});
      expect(parameters, '%7B%7D');
    });

    test('Valid string', () {
      var parameters = retrolite.encodeQueryValue('John');
      expect(parameters, 'John');
    });

    test('String with latin characters', () {
      var parameters = retrolite.encodeQueryValue('João Smith');
      expect(parameters, 'Jo%C3%A3o+Smith');
    });

    test('Integer', () {
      var parameters = retrolite.encodeQueryValue(13579);
      expect(parameters, '13579');
    });

    test('Double', () {
      var parameters = retrolite.encodeQueryValue(13579.02468);
      expect(parameters, '13579.02468');
    });


    test('List with one string', () {
      var parameters = retrolite.encodeQueryValue(['John']);
      expect(parameters, '%5B%22John%22%5D');
    });

    test('List containing one string with latin characters', () {
      var parameters = retrolite.encodeQueryValue(['João Smith']);
      expect(parameters, '%5B%22Jo%C3%A3o+Smith%22%5D');
    });

    test('List with one integer', () {
      var parameters = retrolite.encodeQueryValue([13579]);
      expect(parameters, '%5B13579%5D');
    });

    test('List with one double', () {
      var parameters = retrolite.encodeQueryValue([13579.02468]);
      expect(parameters, '%5B13579.02468%5D');
    });


    test('Map with one string', () {
      var parameters = retrolite.encodeQueryValue({'name':'John'});
      expect(parameters, '%7B%22name%22%3A%22John%22%7D');
    });

    test('Map containing one string with latin characters', () {
      var parameters = retrolite.encodeQueryValue({'name':'João Smith'});
      expect(parameters, '%7B%22name%22%3A%22Jo%C3%A3o+Smith%22%7D');
    });

    test('Map with one integer', () {
      var parameters = retrolite.encodeQueryValue({'int':13579});
      expect(parameters, '%7B%22int%22%3A13579%7D');
    });

    test('Map with one double', () {
      var parameters = retrolite.encodeQueryValue({'double':13579.02468});
      expect(parameters, '%7B%22double%22%3A13579.02468%7D');
    });


    test('List with null value', () {
      var queryParameters = [ null ];
      var parameters = retrolite.encodeQueryValue(queryParameters);
      expect(parameters, '%5Bnull%5D');
    });

    test('List with some primitives', () {
      var queryParameters = [
        'João Smith', 45, 13579.02468
      ];
      var parameters = retrolite.encodeQueryValue(queryParameters);
      expect(parameters, '%5B%22Jo%C3%A3o+Smith%22%2C45%2C13579.02468%5D');
    });

    test('List with empty map', () {
      var queryParameters = [ { } ];
      var parameters = retrolite.encodeQueryValue(queryParameters);
      expect(parameters, '%5B%7B%7D%5D');
    });

    test('List with map', () {
      var queryParameters = [ {
        'name':'João Smith'
      } ];
      var parameters = retrolite.encodeQueryValue(queryParameters);
      expect(parameters, '%5B%7B%22name%22%3A%22Jo%C3%A3o+Smith%22%7D%5D');
    });

    test('List with primitives and map', () {
      var queryParameters = [
        'João Smith', 45, 13579.02468,
        { 'name':'João Smith' }
      ];
      var parameters = retrolite.encodeQueryValue(queryParameters);
      expect(parameters, '%5B%22Jo%C3%A3o+Smith%22%2C45%2C13579.02468%2C%7B%22name%22%3A%22Jo%C3%A3o+Smith%22%7D%5D');
    });

//    test('Test encodeQueryValue with string array', () {
//      var queryParameters = {
//        'id': 1234567,
//        'name': 'João Smith',
//        'phones': ['+554733331234', '+14561234', ',']
//      };
//      var parameters = retrolite.encodeQueryValue(queryParameters);
//      expect(parameters, '?id=1234567&name=Jo%C3%A3o+Smith&phones=%5B%22%2B554733331234%22%2C%22%2B14561234%22%2C%22%2C%22%5D');
//    });
//
//    test('Query parameters with null value building test', () {
//      var queryParameters = {
//        'nullValue': null,
//        'id': 1234567,
//        'name': 'João Smith',
//        'phones': ['+554733331234', '+14561234', ','],
//      };
//      var parameters = retrolite.encodeQueryValue(queryParameters);
//      expect(parameters, '?nullValue=&id=1234567&name=Jo%C3%A3o+Smith&phones=%5B%22%2B554733331234%22%2C%22%2B14561234%22%2C%22%2C%22%5D');
//    });
//
//    test('Query parameters with double value building test', () {
//      var queryParameters = {
//        'double': 13579.23468,
//        'nullValue': null,
//        'id': 1234567,
//        'name': 'João Smith',
//        'phones': ['+554733331234', '+14561234', ','],
//      };
//      var parameters = retrolite.encodeQueryValue(queryParameters);
//      expect(parameters, '?double=13579.23468&nullValue=&id=1234567&name=Jo%C3%A3o+Smith&phones=%5B%22%2B554733331234%22%2C%22%2B14561234%22%2C%22%2C%22%5D');
//    });
//
//    test('Query parameters with empty value building test', () {
//      var queryParameters = {
//        'emptyValue': '',
//        'double': 13579.23468,
//        'nullValue': null,
//        'id': 1234567,
//        'name': 'João Smith',
//        'phones': ['+554733331234', '+14561234', ','],
//      };
//      var parameters = retrolite.encodeQueryValue(queryParameters);
//      expect(parameters, '?emptyValue=&double=13579.23468&nullValue=&id=1234567&name=Jo%C3%A3o+Smith&phones=%5B%22%2B554733331234%22%2C%22%2B14561234%22%2C%22%2C%22%5D');
//    });
//
//    test('Test of building a query parameter containing a map as value', () {
//      var queryParameters = {
//        'city': {
//          'name': 'Londrina',
//          'latitude': -23.31028,
//          'longitude': -51.16278
//        }
//      };
//      var parameters = retrolite.encodeQueryValue(queryParameters);
//      expect(parameters, '?city=%7B%22name%22%3A%22Londrina%22%2C%22latitude%22%3A-23.31028%2C%22longitude%22%3A-51.16278%7D');
//    });
//
  });
}
