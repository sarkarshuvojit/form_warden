import 'package:form_warden/form_warden.dart';

ValidatorFunction between(int lowerLimit, int upperLimit) {
  ValidatorFunction greaterThanLowerLimit = (dynamic? value) {
    if (value.isEmpty) return null;
    var _v = int.parse(value);
    if (_v > lowerLimit && _v < upperLimit) return null;
    return "Value must be between $lowerLimit and $upperLimit";
  };
  return greaterThanLowerLimit;
}

ValidatorFunction floatingPoint = (dynamic? value) {
  if (value.isEmpty) return null;
  try {
    double.parse(value);
  } on FormatException catch (_) {
    return 'Please enter a valid value';
  }
  return null;
};

ValidatorFunction number = (dynamic? value) {
  if (value.isEmpty) return null;
  try {
    int.parse(value);
  } on FormatException catch (_) {
    return 'Please enter a valid value';
  }
  return null;
};