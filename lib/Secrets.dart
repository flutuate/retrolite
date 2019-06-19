import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';

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
class Secrets extends DelegatingMap {
  Secrets(Map base) : super(base);

  /// Load the secrets tokens from an external file. First, the method will search the file
  /// at path '<project-folder>/test/resources/secrets.json', if not found, it
  /// will search at '<project-folder>/resources/secrets.json'.
  static Future<Secrets> loadFromFile() {
    File file = new File('test/resources/secrets.json');
    if (!file.existsSync()) {
      file = new File('resources/secrets.json');
    }
    final String content = file.readAsStringSync();
    var list = json.decode(content);

    final Map<String, String> tokens = {};
    for (Map element in list) {
      var key = element.keys.first;
      var value = element.values.first;
      tokens[key] = value;
    }
    return Future<Secrets>.value(new Secrets(tokens));
  }
}
