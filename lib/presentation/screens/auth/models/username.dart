import 'package:formz/formz.dart';
import 'package:piggybank/presentation/resources/app_strings.dart';

enum UsernameValidationError {
  empty,
  short,
  long;

  String text() {
    switch (this) {
      case UsernameValidationError.short:
        return AppStrings.errorShortUsername;
      case UsernameValidationError.long:
        return AppStrings.errorLongUsername;
      case UsernameValidationError.empty:
        return AppStrings.errorEmptyUsername;
    }
  }
}

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([super.value = '']) : super.dirty();

  @override
  UsernameValidationError? validator(String value) {
    if (value.isEmpty) return UsernameValidationError.empty;

    if (value.length < 4) return UsernameValidationError.short;

    if (value.length > 30) return UsernameValidationError.long;

    return null;
  }
}
