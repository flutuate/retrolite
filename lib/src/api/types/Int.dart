import 'core.dart';

class Int {
  static int parse(var value) {
    if (value is String) {
      return int.parse(value);
    }
    return value;
  }
}

bool isInt(Type type) => isType(type, 'int');
