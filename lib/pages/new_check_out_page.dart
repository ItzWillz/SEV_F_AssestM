import 'package:flutter/material.dart';
import '/services/firestore_storage.dart';
import '/models/asset_instance.dart';

final _formKey = GlobalKey<FormState>();
String description = "";
int serialNum = 0;
String wirelessNIC = "";
AssetInstance newAsset = AssetInstance();

class NewCheckOutPage extends StatelessWidget {
  const NewCheckOutPage({super.key});

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
                                  labelText: 'Description',
                                ),
                                onSaved: (String? value) {
                                  //debugPrint('value for field $index saved as "$value"');
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter description';
                                  }
                                  description = value;
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(width: 20),
                            SizedBox(
                              width: 200,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Serial Number',
                                ),
                                onSaved: (String? value) {
                                  //debugPrint('value for field $index saved as "$value"');
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter Serial Number';
                                  }
                                  serialNum = int.parse(value);
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
                                  labelText: 'WirelessNIC No.',
                                ),
                                onSaved: (String? value) {
                                  //debugPrint('value for field $index saved as "$value"');
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter WirelessNIC No.';
                                  }
                                  wirelessNIC = value;
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
                            newAsset.description = description;
                            newAsset.serialNum = serialNum;
                            newAsset.wirelessNIC = wirelessNIC;
                            
                            FirestoreStorage().insertAssetInstance(newAsset);
                          }
                        },
                        child: const Text('Validate'),
                      ),
                         //Remove elevated button below after checking
                                            ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Printed!'),
                            ));
                            FirestoreStorage().getAsset(serialNum);
                          }
                        },
                        child: const Text('Get'),
                      )
                    ]
                    ),
            //  Column(children: [
            //     Padding(
            //   padding: const EdgeInsets.all(8.0),
            //       child: Row(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           SizedBox(
            //             width: 200,
            //             child: TextFormField(
            //               decoration: const InputDecoration(
            //                 labelText: 'Name3',
            //               ),
            //               onSaved: (String? value) {
            //                 //debugPrint('value for field $index saved as "$value"');
            //               },
            //               validator: (value) {
            //                 if (value == null || value.isEmpty) {
            //                   return 'Enter something3';
            //                 }
            //                 return null;
            //               },
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     ]) 
                ],
            )
              ),
    ));
  }
}