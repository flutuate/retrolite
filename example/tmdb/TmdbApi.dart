import 'package:retrolite/retrolite.dart';
import 'package:retrolite/src/IApi.dart';

import 'Genre.dart';

class TmdbApi
extends IApi
{
  static final String _key = "1f54bd990f1cdfb230adb312546d765d";

  final String language;

  final String region;

  TmdbApi({this.language='en-US', this.region='US'});

  @override
  Future<Genre> genres()
    => api
        ..route = 'movie/upcoming'
        ..parameters = {}
        ;


    // TODO: implement get
    return null;
  }
}