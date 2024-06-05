import 'package:formz/formz.dart';
import 'package:piggybank/presentation/resources/resources.dart';

enum ConfirmPasswordValidationError {
  invalid,
  mismatch;

  String text() {
    switch (this) {
      case ConfirmPasswordValidationError.invalid:
        return AppStrings.errorInvalidPassword;
      case ConfirmPasswordValidationError.mismatch:
        return AppStrings.errorMismatch;
    }
  }
}

class ConfirmPassword extends FormzInput<String, ConfirmPasswordValidationError> {
  final String password;

  const ConfirmPassword.pure({this.password = ''}) : super.pure('');

  const ConfirmPassword.dirty({required this.password, String value = ''}) : super.dirty(value);

  @override
  ConfirmPasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return ConfirmPasswordValidationError.invalid;
    }
    return password == value ? null : ConfirmPasswordValidationError.mismatch;
  }
}
