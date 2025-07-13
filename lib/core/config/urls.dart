import 'package:app_template/core/config/constants.dart';

/// {@template urls}
/// The URLs.
/// {@endtemplate}
enum Urls {
  /// The release URL.
  release(kDefaultUrl),

  /// The development URL.
  development(kDefaultUrl);

  /// The value of the URL.
  const Urls(this.value);

  /// The value of the URL.
  final String value;
}
