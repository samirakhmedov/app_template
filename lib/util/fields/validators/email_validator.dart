import 'package:app_template/generated/app_localizations.dart';
import 'package:app_template/util/fields/validators/field_validator.dart';

/// {@template email_validator.class}
/// Validator that checks email string is valid.
/// {@endtemplate}
class EmailValidator<T extends Object> extends FieldValidator<T> {
  /// Localizations.
  final AppLocalizations localizations;

  /// Validate only if value is presented.
  final bool skipForEmptyValue;

  /// Email pattern.
  final _emailPattern = r'^[\w\-\.]+@([\w-]+\.)+[\w-]+$';

  /// Regexp to check allowed symbols.
  late final RegExp _regExp;

  /// Creates an instance of [EmailValidator].
  EmailValidator(this.localizations, {this.skipForEmptyValue = false}) {
    _regExp = RegExp(_emailPattern);
  }

  @override
  String? validate(Object? value) {
    if (skipForEmptyValue && (value == null || (value is String && value.trim().isEmpty))) {
      return null;
    }

    if (value == null || (value is String && !_regExp.hasMatch(value))) {
      return localizations.commonInvalidEmail;
    }

    return null;
  }
}
