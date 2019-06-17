class Int
{
  static int parse(var value) {
    if( value is String ) {
      return int.parse(value);
    }
    return value;
  }
}