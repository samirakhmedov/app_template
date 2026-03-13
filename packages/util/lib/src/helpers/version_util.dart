import 'dart:math';
import 'dart:typed_data';

abstract class VersionUtil {
  const VersionUtil._();

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

  static String getFormattedVersion(String version) {
    return version.replaceAll('-dev', '');
  }

  static Uint16List _versionNumbers(String version) =>
      Uint16List.fromList(version.split('.').map(int.parse).toList());
}
