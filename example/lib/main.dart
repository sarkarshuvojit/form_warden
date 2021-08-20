import 'package:flutter/material.dart';
import 'package:form_warden/form_warden.dart';

import 'my_validators.dart';

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
