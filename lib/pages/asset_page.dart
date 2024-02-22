import 'package:flutter/material.dart';
import '/services/firestore_storage.dart';
import '/models/asset_instance.dart';
import 'package:provider/provider.dart';
import '../view_models/create_asset_profile.dart';

final _formKey = GlobalKey<FormState>();
String description = "";
int serialNum = 0;
String wirelessNIC = "";
AssetInstance newAsset = AssetInstance();

class AssetPage extends StatefulWidget {
  const AssetPage({super.key, this.profile});
  final String? profile;

    @override
  State<AssetPage> createState() => _AssetPageState();
}

class _AssetPageState extends State<AssetPage> {
  final _profileNameController = TextEditingController();
  @override
  void initState() {
    _profileNameController.text = widget.profile ?? 'None';
    super.initState();
  }

  @override
  void dispose() {
    // implement dispose
    final notifier = Provider.of<CreateAssetNotifier>(context, listen: false);
    notifier.completeAssetSelectScreen();
    super.dispose();
  }

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
                            const SizedBox(width: 20),
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
                           SizedBox(
                             width: 200,
                             child: TextFormField(
                               decoration: const InputDecoration(
                                 labelText: 'Profile Name',
                                ),
                                onSaved: (String? value) {
                                  //debugPrint('value for field $index saved as "$value"');
                                },
                              controller: _profileNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter something2';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      )
                  
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