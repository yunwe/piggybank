import 'package:formz/formz.dart';
import 'package:piggybank/presentation/resources/app_strings.dart';

enum RemarkValidationError {
  long;

  String text() {
    switch (this) {
      case RemarkValidationError.long:
        return AppStrings.errorLongRemark;
    }
  }
}

class Remark extends FormzInput<String, RemarkValidationError> {
  const Remark.pure() : super.pure('');
  const Remark.dirty([super.value = '']) : super.dirty();

  @override
  RemarkValidationError? validator(String value) {
    if (value.length > 35) return RemarkValidationError.long;

    return null;
  }
}
