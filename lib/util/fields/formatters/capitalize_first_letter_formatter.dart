import 'package:app_template/util/extensions/string_extension.dart';
import 'package:flutter/services.dart';

/// {@template capitalize_first_letter_formatter.class}
/// Capitalize only the first letter, and keep the rest of the text as it is.
/// {@endtemplate}
class CapitalizeFirstLetterFormatter extends TextInputFormatter {
  /// {@macro capitalize_first_letter_formatter.class}
  const CapitalizeFirstLetterFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final transformedText = newValue.text.capitalize();
    final selection = newValue.selection;

    return newValue.copyWith(text: transformedText, selection: selection);
  }
}
