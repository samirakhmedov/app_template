/// String extension.
extension StringExtension on String {
  /// Capitalizes the first letter of the string.
  String capitalize() {
    if (length < 2) {
      return toUpperCase();
    }

    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
