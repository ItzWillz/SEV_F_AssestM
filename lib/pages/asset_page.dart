import 'package:flutter/material.dart';

final _formKey = GlobalKey<FormState>();

class AssetPage extends StatelessWidget {
  const AssetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Center(
      child: Form(
          key: _formKey,
            child: Column(
              children: [
                Column(
                    //children: List<Widget>.generate(3, (int index) {
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 200,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Name',
                                ),
                                onSaved: (String? value) {
                                  //debugPrint('value for field $index saved as "$value"');
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter something';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(width: 20),
                            SizedBox(
                              width: 200,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Name2',
                                ),
                                onSaved: (String? value) {
                                  //debugPrint('value for field $index saved as "$value"');
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter something2';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 200,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Name3',
                                ),
                                onSaved: (String? value) {
                                  //debugPrint('value for field $index saved as "$value"');
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter something3';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Great!'),
                            ));
                          }
                        },
                        child: const Text('Validate'),
                      )
                    ]
                    ),
             Column(children: [
                Padding(
              padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 200,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Name3',
                          ),
                          onSaved: (String? value) {
                            //debugPrint('value for field $index saved as "$value"');
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter something3';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                ]) 
                ],
            )
              ),
    ));
  }
}
