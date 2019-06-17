class Double
{
  static double parse(var value) {
    if( value is int ) {
      return 0.0 + value;
    }
    else if( value is String ) {
      return double.parse(value);
    }
    return value;
  }

}
