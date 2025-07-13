import 'package:app_template/generated/app_localizations.dart';
import 'package:app_template/util/fields/validators/field_validator.dart';

/// Validator that checks if the field is filled.
class FillValidator<T extends Object?> extends FieldValidator<T> {
  /// Localizations.
  final AppLocalizations localizations;

  /// Creates an instance of [FillValidator].
  const FillValidator(this.localizations);

  @override
  String? validate(Object? value) {
    if (value == null ||
        (value is String && value.trim().isEmpty) ||
        (value is Iterable && value.isEmpty)) {
      return localizations.commonRequiredField;
    }

    return null;
  }
}
