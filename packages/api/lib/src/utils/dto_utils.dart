// ignore_for_file: no-object-declaration

import 'dart:convert';

/// Utility class for dtos.
abstract class DtoUtils {
  const DtoUtils._();

  /// Safely reads list like value of [json] map.
  static Object? readList(Map<dynamic, dynamic> json, String key) {
    final rawValue = json[key];

    if (rawValue is List) {
      return rawValue;
    }

    if (rawValue is String) {
      try {
        final tryParse = jsonDecode(rawValue);

        if (tryParse is List) {
          return tryParse;
        }

        return null;
      } on Object catch (_) {
        return null;
      }
    }

    return null;
  }

  /// Safely reads string like value of [json] map.
  static Object? readString(Map<dynamic, dynamic> data, String key) {
    final rawData = data[key];

    if (rawData == null) {
      return null;
    }

    if (rawData is String) {
      final lowerCase = rawData.toLowerCase();

      if (lowerCase == 'null') {
        return null;
      }

      return rawData;
    }

    return rawData.toString();
  }

  /// Safely reads int like value of [json] map.
  static Object? readInt(Map<dynamic, dynamic> json, String key) {
    final rawValue = json[key];

    if (rawValue is num) {
      return rawValue.toInt();
    }

    if (rawValue is String) {
      return int.tryParse(rawValue);
    }

    return null;
  }

  /// Safely reads bool like value of [json] map.
  static Object? readBool(Map<dynamic, dynamic> json, String key) {
    final rawData = json[key];

    if (rawData == null) {
      return null;
    }

    if (rawData is String) {
      final lower = rawData.toLowerCase();

      if (lower.isEmpty || lower == 'null') return null;

      if (lower == '1') return true;
      if (lower == '0') return false;

      if (lower == 'yes') return true;
      if (lower == 'no') return false;

      if (lower == 'y') return true;
      if (lower == 'n') return false;

      return bool.tryParse(rawData, caseSensitive: false);
    }

    if (rawData is bool) {
      return rawData;
    }

    if (rawData is num) {
      return rawData.round() == 1;
    }

    return null;
  }

  /// Safely reads map like value of [json] map.
  static Object? readMap(Map<dynamic, dynamic> json, String key) {
    final rawData = json[key];

    if (rawData == null) {
      return null;
    }

    if (rawData is Map) {
      return rawData;
    }

    if (rawData is String) {
      try {
        final tryParse = jsonDecode(rawData);

        if (tryParse is Map) {
          return tryParse;
        }

        return null;
      } on Object catch (_) {
        return null;
      }
    }

    return null;
  }
}
