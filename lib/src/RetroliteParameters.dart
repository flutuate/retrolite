import 'package:http/http.dart' as http;

class RetroliteParameters
{
  final String baseUrl;

  final http.BaseClient client;

  RetroliteParameters(this.baseUrl, this.client);
}

