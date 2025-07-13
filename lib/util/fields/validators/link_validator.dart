import 'package:app_template/generated/app_localizations.dart';
import 'package:app_template/util/fields/validators/field_validator.dart';

/// Validator that checks if the field is filled.
class LinkValidator extends FieldValidator<String> {
  /// Localizations.
  final AppLocalizations localizations;

  /// Creates an instance of [LinkValidator].
  const LinkValidator(this.localizations);

  @override
  String? validate(String? value) {
    final linkRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)',
    );

    if (value == null || value.trim().isEmpty) {
      return localizations.commonRequiredField;
    }

    if (!linkRegex.hasMatch(value)) {
      return localizations.commonInvalidLink;
    }

    return null;
  }
}
