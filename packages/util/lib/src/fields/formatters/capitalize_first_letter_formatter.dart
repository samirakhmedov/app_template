import 'package:flutter/services.dart';
import 'package:util/src/extensions/string_extension.dart';

class CapitalizeFirstLetterFormatter extends TextInputFormatter {
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
