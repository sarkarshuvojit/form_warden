library form_warden;

typedef ValidatorFunction = dynamic? Function(dynamic? value);

ValidatorFunction createWarden(Iterable<ValidatorFunction> validators) {
  dynamic validatorFunction(dynamic value) {
    for (Function validator in validators) {
      dynamic validatorResult = validator(value);
      if (validatorResult != null) {
        return validatorResult;
      }
    }
    return null;
  }

  return validatorFunction;
}

class Validators {
  static ValidatorFunction required = (dynamic? value) {
    if (value == null || value.isEmpty || value.toString().trim().isEmpty) {
      return 'Field cannot be empty';
    }
    return null;
  };

  static ValidatorFunction email = (dynamic? value) {
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return null;
    }
    return 'Invalid email id';
  };
}
