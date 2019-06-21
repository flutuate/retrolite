import 'core.dart';

class Double {
  static double parse(var value) {
    if (value is int) {
      return 0.0 + value;
    } else if (value is String) {
      return double.parse(value);
    }
    return value;
  }
}

bool isDouble(Type type) => isType(type, 'double');
