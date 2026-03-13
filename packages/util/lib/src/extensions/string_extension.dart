extension StringExtension on String {
  String capitalize() {
    if (length < 2) {
      return toUpperCase();
    }

    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
