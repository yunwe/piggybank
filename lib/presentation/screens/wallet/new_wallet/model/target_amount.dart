import 'package:formz/formz.dart';
import 'package:piggybank/presentation/resources/app_strings.dart';

enum WalletTargetAmountValidationError {
  empty,
  lessThanZero,
  notNumber;

  String text() {
    switch (this) {
      case WalletTargetAmountValidationError.empty:
        return AppStrings.errorEmptyInput;
      case WalletTargetAmountValidationError.notNumber:
        return AppStrings.errorNotANumber;
      case WalletTargetAmountValidationError.lessThanZero:
        return AppStrings.errorLessThanZero;
    }
  }
}

class WalletTargetAmount extends FormzInput<String, WalletTargetAmountValidationError> {
  const WalletTargetAmount.pure() : super.pure('');
  const WalletTargetAmount.dirty([super.value = '']) : super.dirty();

  @override
  WalletTargetAmountValidationError? validator(String value) {
    if (value.isEmpty) return WalletTargetAmountValidationError.empty;

    double? target = double.tryParse(value);
    if (target == null) {
      return WalletTargetAmountValidationError.notNumber;
    }

    if (target <= 0) {
      return WalletTargetAmountValidationError.lessThanZero;
    }

    return null;
  }
}
