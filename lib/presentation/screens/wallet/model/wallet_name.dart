import 'package:formz/formz.dart';
import 'package:piggybank/presentation/resources/app_strings.dart';

enum WalletNameValidationError {
  empty,
  short,
  long;

  String text() {
    switch (this) {
      case WalletNameValidationError.short:
        return AppStrings.errorShortWalletname;
      case WalletNameValidationError.long:
        return AppStrings.errorLongWalletname;
      case WalletNameValidationError.empty:
        return AppStrings.errorEmptyInput;
    }
  }
}

class WalletName extends FormzInput<String, WalletNameValidationError> {
  const WalletName.pure() : super.pure('');
  const WalletName.dirty([super.value = '']) : super.dirty();

  @override
  WalletNameValidationError? validator(String value) {
    if (value.isEmpty) return WalletNameValidationError.empty;

    if (value.length < 4) return WalletNameValidationError.short;

    if (value.length > 50) return WalletNameValidationError.long;

    return null;
  }
}
