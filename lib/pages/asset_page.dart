import 'package:flutter/material.dart';
import 'package:ocassetmanagement/models/asset_profile.dart';
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
  //final _assetProfile = FirestoreStorage().getAsset(serialNum);

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
    
    // return FutureBuilder<List<AssetInstance>>(
    //   future: _assetProfile,
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       // While the future is still running, show a loading indicator or placeholder
    //       return const CircularProgressIndicator();
    //     } else if (snapshot.hasError) {
    //       // If there's an error, display an error message
    //       return Text('Error: ${snapshot.error}');
    //     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
    //       // If there's no data or the data is empty, display a message
    //       return const Text('No users found.');
    //     } else {
    return Material(
        // child: Center(
      child: Form(
          key: _formKey,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, left: 50, right: 50),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: 
                          Column(
                            children: [
                              const Row(
                                        //mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            width: 200,
                                            child: Text('Asset Info', style: TextStyle(fontSize: 25),),
                                          ),
                                        ],
                                      ),
                              Row(
                               // mainAxisSize: MainAxisSize.min,
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
                              Row(
                               // mainAxisSize: MainAxisSize.min,
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
                              
                                
                            ],
                          ),
                      ),  
                              //const Spacer(),
                              Expanded(
                                flex: 4,
                                child: 
                                  Column(
                                    children: [
                                       const Row(
                                        //mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            width: 200,
                                            child: Text('Profile Info', style: TextStyle(fontSize: 25),),
                                          ),
                                        ],
                                      ),
                                      Row(children: [
                                        SizedBox(
                                            width: 150,
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
                                          return 'Must have Specific Profile or None';
                                        }
                                        return null;
                                      },
                                    ),
                                          ),
                                        const Spacer(),
                                          SizedBox(
                                            width: 220,
                                            child: ElevatedButton(child: const Text('Change or Remove Profile'),
                                            onPressed: () {  },),
                                          ),
                                          const SizedBox(width: 20,),
                                          SizedBox(
                                            width: 150,
                                            child: ElevatedButton(child: const Text('Edit Profile'),
                                            onPressed: () {  },),
                                          ),],),
                                      Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              width: 200,
                                              child: TextFormField(
                                                decoration: const InputDecoration(
                                                  labelText: 'Manufacturer',
                                                ),
                                                //initialValue: _assetManufacturer,
                                                // if (AssetProfile.fromFirestore().manufacturer.isNotEmpty){
                                                // initialValue: AssetProfile.fromFirestore(snapshot).manufacturer,
                                                // },
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
                                    ],
                                  ),
                                
                              ),
                              
                    ],
                  ),
                ),
                const SizedBox(height: 30,), 
                Row(
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: ElevatedButton(
                        onPressed: () { //Route back to checked out list
                        dispose();
                        },
                        child: const Text('Cancel'),
                      ),
                          ),
                          const SizedBox(width: 20,),
                          SizedBox(
                            width: 100,
                            child: ElevatedButton(
                                          onPressed: () {
                                            if (_formKey.currentState!.validate()) {
                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                content: Text('Asset Saved!'),
                                              ));
                                              newAsset.description = description;
                                              newAsset.serialNum = serialNum;
                                              newAsset.wirelessNIC = wirelessNIC;
                                              
                                              FirestoreStorage().insertAssetInstance(newAsset);
                                            }
                                          },
                                          child: const Text('Submit'),
                                        ),
                                         //Remove elevated button below after checking
                                  //  ElevatedButton(
                                  //   onPressed: () {
                                  //     if (_formKey.currentState!.validate()) {
                                  //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  //         content: Text('Printed!'),
                                  //       ));
                                  //       FirestoreStorage().getAsset(serialNum);
                                  //     }
                                  //   },
                                  //   child: const Text('Get'),
                                  // ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ],
            )
              ),
    // )
    );
  
  }
  //     });
  // }
}