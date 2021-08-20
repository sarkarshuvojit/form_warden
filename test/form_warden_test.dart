import 'package:flutter_test/flutter_test.dart';

import 'package:form_warden/form_warden.dart';

void main() {
  test('test required validator', () {
    // Valid
    expect(Validators.required("Abc"), null);

    // Invalid
    expect(Validators.required("") is String, true);
    expect(Validators.required("   ") is String, true);
  });

  test('test email validator', () {
    // Invalid
    expect(Validators.email("") is String, true);
    expect(Validators.email("Abc") is String, true);
    expect(Validators.email("abc@cdf") is String, true);

    // Valid
    expect(Validators.email("abc@cdf.com"), null);
    expect(Validators.email("abcd@example.com"), null);
    expect(Validators.email("abcd123@example.com"), null);
    expect(Validators.email("abcd123.def456@example.com"), null);
    expect(Validators.email("abcd123_def456@example.com"), null);
  });

  test("test warden: 10 < x < 100", () {
    ValidatorFunction greaterThanTen = (value) {
      if (value is int && value > 10) {
        return null;
      }
      return "Must be greater than 10";
    };
    ValidatorFunction lessThanHundred = (value) {
      if (value is int && value < 100) {
        return null;
      }
      return "Must be less than 100";
    };
    ValidatorFunction warden = createWarden([greaterThanTen, lessThanHundred]);

    // Invalid
    expect(warden(5) is String, true);
    expect(warden(111) is String, true);
    expect(warden(200) is String, true);
    expect(warden(4) is String, true);
    expect(warden(3) is String, true);

    // Valid
    expect(warden(11), null);
    expect(warden(50), null);
    expect(warden(80), null);
    expect(warden(99), null);
  });

}
