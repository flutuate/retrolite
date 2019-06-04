import 'dart:convert';
import 'dart:io';

import 'package:retrolite/flutuate_http.dart';
import 'package:retrolite/retrolite.dart';
import 'package:test/test.dart';

void main()
{
  group('Retrolite.buildHeaders tests', () {

    Retrolite retrolite;

    setUpAll(() {
      retrolite = Retrolite('http://localhost/');
    });

    test('Test with accepts header and some parameters', () {
      Header accepts = Headers.Accepts('text/plain', {'q':'0.3'});
      accepts.add('text/html');
      Map<String,String> buildedHeaders = retrolite.buildHeaders( [
        accepts
      ] );
      expect(buildedHeaders, contains(HttpHeaders.acceptHeader));
      expect(buildedHeaders, isNotEmpty);
    });

    test('Test buildHeaders with custom header and some parameters', () {
      Header myHeader = Headers.custom(
          'my-header',
          value: 'my-value',
          parameters: [
            {'charset': utf8.name},
            'text/html'
          ]
      );
      Map<String,String> buildedHeaders = retrolite.buildHeaders( [
        myHeader
      ] );
      expect(buildedHeaders, contains('my-header'));
      expect(buildedHeaders, isNotEmpty);
    });

  });
}

