import '/core/constants/app_constants.dart';

class FormValidators {
  static String? required(String? value) {
    return value?.isEmpty ?? true ? AppConstants.requiredFieldMessage : null;
  }

  static String? number(String? value) {
    if (value == null || value.isEmpty) return null;
    return double.tryParse(value) == null
        ? AppConstants.invalidNumberMessage
        : null;
  }

  static String? requiredNumber(String? value) {
    return required(value) ?? number(value);
  }
}
