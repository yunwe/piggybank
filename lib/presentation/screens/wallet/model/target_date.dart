import 'package:formz/formz.dart';
import 'package:piggybank/presentation/resources/resources.dart';

enum WalletTargetDateValidationError {
  empty,
  invalid;

  String text() {
    switch (this) {
      case WalletTargetDateValidationError.empty:
        return AppStrings.errorEmptyInput;
      case WalletTargetDateValidationError.invalid:
        return AppStrings.errorInvalidTargetDate;
    }
  }
}

class WalletTargetDate extends FormzInput<DateTime?, WalletTargetDateValidationError> {
  const WalletTargetDate.pure() : super.pure(null);
  const WalletTargetDate.dirty([super.value]) : super.dirty();

  @override
  WalletTargetDateValidationError? validator(DateTime? value) {
    if (value == null) return WalletTargetDateValidationError.empty;

    final today = DateTime.now();
    final threeYearsFromToday = DateTime(today.year + 3, today.month, today.day);

    if (value.isBefore(today) || value.isAfter(threeYearsFromToday)) {
      return WalletTargetDateValidationError.invalid;
    }

    return null;
  }
}
