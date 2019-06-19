import 'package:retrolite/Secrets.dart';
import 'package:test/test.dart';

void main() {
  group('Secret tests', () {
    test('Test if Secrets loads resource file correctly', () async {
      Secrets secrets = await Secrets.loadFromFile();
      expect(secrets, isNotNull);
      expect(secrets['tmdb_token'], isNotNull);
    });
  });
}
