import 'package:formz/formz.dart';
import 'package:piggybank/presentation/resources/app_strings.dart';

enum AmountValidationError {
  empty,
  lessThanZero,
  notNumber;

  String text() {
    switch (this) {
      case AmountValidationError.empty:
        return AppStrings.errorEmptyInput;
      case AmountValidationError.notNumber:
        return AppStrings.errorNotANumber;
      case AmountValidationError.lessThanZero:
        return AppStrings.errorLessThanZero;
    }
  }
}

class Amount extends FormzInput<String, AmountValidationError> {
  const Amount.pure() : super.pure('');
  const Amount.dirty([super.value = '']) : super.dirty();

  @override
  AmountValidationError? validator(String value) {
    if (value.isEmpty) return AmountValidationError.empty;

    double? amount = double.tryParse(value);
    if (amount == null) {
      return AmountValidationError.notNumber;
    }

    if (amount <= 0) {
      return AmountValidationError.lessThanZero;
    }

    return null;
  }
}
