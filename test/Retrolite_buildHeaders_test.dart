import 'dart:io';

import 'package:retrolite/flutuate_http.dart';
import 'package:retrolite/retrolite.dart';
import 'package:test/test.dart';

/// TODO add tests using the ContentType parameter on 'parseHeaders' method.
void main()
{
  group('Retrolite.parseHeaders tests', () {

    Retrolite retrolite;

    setUpAll(() {
      retrolite = Retrolite('http://localhost/');
    });

    test('Passing a null headers list', () {
      Map<String,String> buildedHeaders = retrolite.parseHeaders( null, null );

      expect(buildedHeaders, isEmpty);
    });

    test('Passing an empty headers list', () {
      Map<String,String> buildedHeaders = retrolite.parseHeaders( null, [] );

      expect(buildedHeaders, isEmpty);
    });

    test('Passing a headers list containing an null element throws exception', () {
      expect( () => retrolite.parseHeaders(null, [null]), throwsArgumentError );
    });

    test('Passing an accept header', () {
      Header acceptHeader = new Header(
          HttpHeaders.acceptHeader,
          ContentType.text
      );

      Map<String,String> buildedHeaders = retrolite.parseHeaders( null, [
        acceptHeader
      ] );

      expect(buildedHeaders, isNotEmpty);
      expect(buildedHeaders, contains(HttpHeaders.acceptHeader));
      expect(buildedHeaders[HttpHeaders.acceptHeader], ContentType.text.toString());
    });

    test('Passing an accept header with parameters', () {
      List parameters = [
        'João Smith', 45, 1.23,
        ['abc', 123, 4.56, true],
        { 'v1': 1, 'v2': 0.2, 'v3': '3', 'v4': true, }
      ];

      Header acceptHeader = new Header(
          HttpHeaders.acceptHeader,
          ContentType.text,
          parameters
      );

      Map<String,String> buildedHeaders = retrolite.parseHeaders( null, [
        acceptHeader
      ] );

      expect(buildedHeaders, isNotEmpty);
      expect(buildedHeaders, contains(HttpHeaders.acceptHeader));
      expect(buildedHeaders[HttpHeaders.acceptHeader], ContentType.text.toString() + ';João Smith,45,1.23,abc,123,4.56,true,v1=1,v2=0.2,v3=3,v4=true');
    });


  });
}

