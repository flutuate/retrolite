import 'dart:convert';
import 'dart:io';

///
/// A convenience class to read secrets tokens from a resource file.
///
/// The resource file, at path [resources/secrets.json] or [test/resources/secrets.json] in the case of unit tests.
/// It must be the follow format:
///
/// ```json
/// [
///    {
///       "<name-of-token-0>": "<your-token-0>"
///    }
///    ,```
/// ```
///     ...
/// ```
/// ```json
///    {
///       "<name-of-token-N>": "<your-token-N>"
///    }
/// ]
/// ```
/// 
class Secrets
{
  final Map<String,String> _tokens = {};

  factory Secrets._fromJson(Map<String, String> jsonMap) {
    return new Secrets(mixpanelToken: jsonMap['mixpanel_token']);
  }

  /// Load the json resource file that contains the secret tokens.
  /// The method returns an instance of [Secrets].
  ///
  /// Set [inUnitTest] as ```true``` to load the token from an external file.
  /// See [loadFromFile].
  static Future<Secrets> load({bool inUnitTest = false}) {
    if (inUnitTest) {
      return loadFromFile();
    }
  }

  /// Load the token from an external file. First, the method will search the file
  /// at path '<project-folder>/test/resources/secrets.json', if not found, it
  /// will search at '<project-folder>/resources/secrets.json'.
  static Future<Secrets> loadFromFile() {
    File file = new File('test/resources/secrets.json');
    if (!file.existsSync()) {
      file = new File('resources/secrets.json');
    }
    final String content = file.readAsStringSync();
    final Map map = json.decode(content);
    return Future<Secrets>.value(Secrets._fromJson(map));
  }
}
