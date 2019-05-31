import 'package:retrolite/retrolite.dart';
import 'package:test/test.dart';

void main() {
  group('Retrolite.encodeQueryValue tests', () {

    var retrolite;

    setUpAll(() {
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

    //~~~~~~~~~~~~~~~~

    test('List with null', () {
      var parameters = retrolite.encodeQueryValue([null]);
      expect(parameters, '%5Bnull%5D');
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

    //~~~~~~~~~~~~~~

    test('List with null value', () {
      var queryParameters = [ null ];
      var parameters = retrolite.encodeQueryValue(queryParameters);
      expect(parameters, '%5Bnull%5D');
    });

    test('List with some primitives', () {
      var queryParameters = [
        'João Smith', 45, 13579.02468,
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
        { 'name': 'João Smith'}
      ];
      var parameters = retrolite.encodeQueryValue(queryParameters);
      expect(parameters, '%5B%22Jo%C3%A3o+Smith%22%2C45%2C13579.02468%2C%7B%22name%22%3A%22Jo%C3%A3o+Smith%22%7D%5D');
    });

    test('List with primitives, map and list', () {
      var queryParameters = [
        'João Smith', 45, 13579.02468, '+554730303030',
        { 'name': 'João Smith'},
        [ 'Londrina', -23.31028, -51.16278]
      ];
      var parameters = retrolite.encodeQueryValue(queryParameters);
      expect(parameters, '%5B%22Jo%C3%A3o+Smith%22%2C45%2C13579.02468%2C%22%2B554730303030%22%2C%7B%22name%22%3A%22Jo%C3%A3o+Smith%22%7D%2C%5B%22Londrina%22%2C-23.31028%2C-51.16278%5D%5D');
    });

    test('List with primitives, map and list, with special values', () {
      var queryParameters = [
        'João Smith', 45, 13579.02468,
        {
          'name': 'João Smith',
          'nullvalue': null,
          'emptyValue': '',
          'comma': ',',
          'specialChars': '%\\\\/@#:\'\\"'
        },
        [ 'Londrina', -23.31028, -51.16278, null, '', ',', '%\\\\/@#:\'\\"']
      ];
      var parameters = retrolite.encodeQueryValue(queryParameters);
      expect(parameters, '%5B%22Jo%C3%A3o+Smith%22%2C45%2C13579.02468%2C%7B%22name%22%3A%22Jo%C3%A3o+Smith%22%2C%22nullvalue%22%3Anull%2C%22emptyValue%22%3A%22%22%2C%22comma%22%3A%22%2C%22%2C%22specialChars%22%3A%22%25%5C%5C%5C%5C%2F%40%23%3A%27%5C%5C%5C%22%22%7D%2C%5B%22Londrina%22%2C-23.31028%2C-51.16278%2Cnull%2C%22%22%2C%22%2C%22%2C%22%25%5C%5C%2F%40%23%3A%27%5C%22%22%5D%5D');
    });

    //~~~~~~~~~~~~~~~~

    test('Map with null value', () {
      var queryParameters = { 'nullValue': null };
      var parameters = retrolite.encodeQueryValue(queryParameters);
      expect(parameters, '%7B%22nullValue%22%3Anull%7D');
    });

    test('List with some primitives', () {
      var queryParameters = [
        'João Smith', 45, 13579.02468
      ];
      var parameters = retrolite.encodeQueryValue(queryParameters);
      expect(parameters, '%5B%22Jo%C3%A3o+Smith%22%2C45%2C13579.02468%5D');
    });

    test('Map with empty map', () {
      var queryParameters = { { } };
      var parameters = retrolite.encodeQueryValue(queryParameters);
      expect(parameters, '%7B%7B%7D%7D');
    });

    test('Map with map', () {
      var queryParameters = { {
        'name':'João Smith'
      } };
      var parameters = retrolite.encodeQueryValue(queryParameters);
      expect(parameters, '%7B%7Bname%3A+Jo%C3%A3o+Smith%7D%7D');
    });

    test('Map with primitives and map', () {
      var queryParameters = {
        'name':'João Smith', 'age':45, 'double':13579.02468,
        'map': { 'name': 'João Smith'}
      };
      var parameters = retrolite.encodeQueryValue(queryParameters);
      expect(parameters, '%7B%22name%22%3A%22Jo%C3%A3o+Smith%22%2C%22age%22%3A45%2C%22double%22%3A13579.02468%2C%22map%22%3A%7B%22name%22%3A%22Jo%C3%A3o+Smith%22%7D%7D');
    });

    test('Map with primitives, map and list', () {
      var queryParameters = {
        'name': 'João Smith', 'age': 45, 'double': 13579.02468, 'phone':'+554730303030',
        'map': { 'name': 'João Smith'},
        'list': [ 'Londrina', -23.31028, -51.16278]
      };
      var parameters = retrolite.encodeQueryValue(queryParameters);
      expect(parameters, '%7B%22name%22%3A%22Jo%C3%A3o+Smith%22%2C%22age%22%3A45%2C%22double%22%3A13579.02468%2C%22phone%22%3A%22%2B554730303030%22%2C%22map%22%3A%7B%22name%22%3A%22Jo%C3%A3o+Smith%22%7D%2C%22list%22%3A%5B%22Londrina%22%2C-23.31028%2C-51.16278%5D%7D');
    });

    test('Map with primitives, map and list, with special values', () {
      var queryParameters = {
        'name': 'João Smith',
        'age': 45,
        'number': 13579.02468,
        'map': {
          'name': 'João Smith',
          'nullvalue': null,
          'emptyValue': '',
          'comma': ',',
          'specialChars': '%\\\\/@#:\'\\"'
        },
        'list': [
          'Londrina',
          -23.31028,
          -51.16278,
          null,
          '',
          ',',
          '%\\\\/@#:\'\\"'
        ]
      };
      var parameters = retrolite.encodeQueryValue(queryParameters);
      expect(parameters,
          '%7B%22name%22%3A%22Jo%C3%A3o+Smith%22%2C%22age%22%3A45%2C%22number%22%3A13579.02468%2C%22map%22%3A%7B%22name%22%3A%22Jo%C3%A3o+Smith%22%2C%22nullvalue%22%3Anull%2C%22emptyValue%22%3A%22%22%2C%22comma%22%3A%22%2C%22%2C%22specialChars%22%3A%22%25%5C%5C%5C%5C%2F%40%23%3A%27%5C%5C%5C%22%22%7D%2C%22list%22%3A%5B%22Londrina%22%2C-23.31028%2C-51.16278%2Cnull%2C%22%22%2C%22%2C%22%2C%22%25%5C%5C%5C%5C%2F%40%23%3A%27%5C%5C%5C%22%22%5D%7D');
    });
  });
}
