class AppSystemUiOverlayStyle {
  final bool isDark;

  const AppSystemUiOverlayStyle({this.isDark = false});

  static const light = AppSystemUiOverlayStyle();
  static const dark = AppSystemUiOverlayStyle(isDark: true);
}
