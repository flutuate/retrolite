import 'package:http/http.dart' as http;

import 'IRestClient.dart';

abstract class RetroliteParameters
extends IRestClient
{
  final String baseUrl;

  final http.BaseClient httpClient;

  RetroliteParameters(this.baseUrl, this.httpClient);
}
