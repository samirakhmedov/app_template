import 'package:app_assets/app_assets.dart';
import 'package:util/src/fields/validators/field_validator.dart';

/// Validator that checks if the field is filled.
class CapValidator extends FieldValidator<String> {
  /// Localizations.
  final AppLocalizations localizations;

  /// The amount of symbols available.
  final int symbols;

  /// Creates an instance of [FieldValidator].
  const CapValidator(this.localizations, {this.symbols = 15});

  @override
  String? validate(String? value) {
    if (value == null || (value.length < symbols)) {
      return localizations.commonAtLeastSymbols(symbols);
    }

    return null;
  }
}
