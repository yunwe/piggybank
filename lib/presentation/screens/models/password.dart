import 'package:formz/formz.dart';
import 'package:mvmm_auth_demo/presentation/resources/app_strings.dart';

enum PasswordValidationError {
  empty,
  invalid;

  String text() {
    switch (this) {
      case PasswordValidationError.invalid:
        return AppStrings.errorInvalidPassword;
      case PasswordValidationError.empty:
        return AppStrings.errorEmptyPassword;
    }
  }
}

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([super.value = '']) : super.dirty();

  static final _passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return PasswordValidationError.empty;
    } else if (!_passwordRegex.hasMatch(value)) {
      return PasswordValidationError.invalid;
    }

    return null;
  }
}
