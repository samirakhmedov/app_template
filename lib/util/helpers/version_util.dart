import 'dart:math';
import 'dart:typed_data';

/// Version utils.
abstract class VersionUtil {
  const VersionUtil._();

  /// Compares 2 versions provided in string representation.
  ///
  /// For example:
  /// - 1.1.0, 1.0.3 -> returns `true`
  /// - 1, 2.0.4 -> returns `false`
  /// - 3, 1.5.3 -> returns `true`,
  /// - null, 1.0.4 -> returns `true`,
  /// - null, '' -> returns `true`,
  /// - null, '1.0.4' -> returns `true`,
  ///
  /// If both parameters could be parsed and used, and [first] app version is bigger than [second], then returns true.
  ///
  /// In any other case returns false.
  ///
  /// `false` means that force-update logic should be executed.
  static bool compareVersions(String? first, String? second) {
    if (first == null && second == null) return true;

    if (first == null || second == null) return true;

    if (second.isEmpty || first.isEmpty) return true;

    if (first == second) return true;

    try {
      final firstNumbers = _versionNumbers(first);

      final secondNumbers = _versionNumbers(second);

      final length = min(firstNumbers.length, secondNumbers.length);

      for (var index = 0; index < length; index += 1) {
        final firstSection = firstNumbers.elementAtOrNull(index);

        final secondSection = secondNumbers.elementAtOrNull(index);

        if (firstSection == null || secondSection == null) return true;

        if (firstSection < secondSection) {
          return false;
        }

        if (firstSection > secondSection) {
          return true;
        }
      }

      return true;
    } on Object {
      return true;
    }
  }

  /// Returns `true` if [first] and [second] versions are equal.
  static bool isSameVersions({required String first, required String second}) {
    try {
      final firstNumbers = _versionNumbers(first);
      final secondNumbers = _versionNumbers(second);
      final length = min(firstNumbers.length, secondNumbers.length);

      var isEqual = true;

      for (var index = 0; index < length; index += 1) {
        final firstSection = firstNumbers.elementAtOrNull(index);
        final secondSection = secondNumbers.elementAtOrNull(index);

        if ((firstSection == null || secondSection == null) || (firstSection != secondSection)) {
          isEqual = false;

          break;
        }
      }

      return isEqual;
    } on FormatException catch (_) {
      return false;
    }
  }

  /// Returns formatted app version.
  static String getFormattedVersion(String version) {
    return version.replaceAll('-dev', '');
  }

  /// Maps version to number format.
  static Uint16List _versionNumbers(String version) =>
      Uint16List.fromList(version.split('.').map(int.parse).toList());
}
