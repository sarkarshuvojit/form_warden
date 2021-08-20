import 'package:flutter/material.dart';
import 'package:form_warden/form_warden.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Warden Example',
      home: ExampleScreen(),
    );
  }
}

class _FormField {
  final String label;
  final List<dynamic Function(dynamic?)> validators;

  _FormField(this.label, this.validators);
}

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({Key? key}) : super(key: key);

  @override
  _ExampleScreenState createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  final _form = GlobalKey<FormState>();
  late final List<_FormField> _formFields;

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

  @override
  void initState() {
    super.initState();
    this._formFields = [
      _FormField(
        "Name",
        [Validators.required],
      ),
      _FormField(
        "Only floating point",
        [Validators.required, floatingPoint],
      ),
      _FormField(
        "Between 10 and 100",
        [Validators.required, number, between(10, 100)],
      ),
      _FormField(
        "Valid Email",
        [Validators.required, Validators.email],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Warden Example"),
      ),
      body: Container(
        child: Form(
          key: this._form,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            child: Wrap(
              alignment: WrapAlignment.center,
              runSpacing: 20,
              children: [
                ..._formFields.map(
                  (f) => TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: createWarden(f.validators),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: f.label,
                    ),
                    onSaved: null,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      this._form.currentState!.validate();
                    },
                    child: Text('Validate'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
