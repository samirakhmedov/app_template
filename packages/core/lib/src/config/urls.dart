import 'package:core/src/config/constants.dart';

enum Urls {
  release('$kDefaultUrl/release'),

  development('$kDefaultUrl/test')
  ;

  const Urls(this.value);

  final String value;
}
