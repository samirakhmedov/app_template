import 'package:app_template/util/fields/validators/field_validator.dart';

/// Validator that combines multiple validators.
///
/// This validator returns the first error message from the list of validators.
class MergedValidator<T extends Object?> extends FieldValidator<T> {
  /// List of validators.
  final List<FieldValidator<T>> validators;

  /// Creates an instance of [MergedValidator].
  const MergedValidator(this.validators);

  @override
  String? validate(T? value) {
    for (final validator in validators) {
      final result = validator.validate(value);
      if (result != null) {
        return result;
      }
    }

    return null;
  }
}
