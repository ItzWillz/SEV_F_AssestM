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
child: Padding(
padding: const EdgeInsets.all(8.0),
child: ListView(
children: [
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisSize: MainAxisSize.min,
  children: [
    const Text("Check Out Device Form"),
    Form(
      key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              
                Row(
                  children: [
                    SizedBox(
                      width: 200,
                      child: DropdownButtonFormField(
                         decoration: const InputDecoration(
                              labelText: 'Person',
                            ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter Person';
                                    }
                                description = value;
                                return null;
                                  }, items: const [
                                   // ignore: sort_child_properties_last
                                   DropdownMenuItem(child: Text("Person"),value: "Person"),
                                  ], onChanged: (String? value) {  },
                                ),
                              ),
                  ],
                ),
                          Row(
                            children: [
                              SizedBox(
                                width: 200,
                                child: DropdownButtonFormField(
                                                 decoration: const InputDecoration(
                              labelText: 'Building',
                                                    ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter Building';
                                    }
                                description = value;
                                return null;
                                  }, items: const [
                                   // ignore: sort_child_properties_last
                                   DropdownMenuItem(child: Text("Building"),value: "Building"),
                                  ], onChanged: (String? value) {  },
                                ),
                              ),
                            ],
                          ),
                        
                    
                          Row(
                            children: [
                              SizedBox(
                                width: 200,
                                child: DropdownButtonFormField(
                                                 decoration: const InputDecoration(
                              labelText: 'Room',
                                                    ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter Room';
                                    }
                                description = value;
                                return null;
                                  }, items: const [
                                   // ignore: sort_child_properties_last
                                   DropdownMenuItem(child: Text("Room"),value: "Room"),
                                  ], onChanged: (String? value) {  },
                                ),
                              ),
                            ],
                          ),
          
                          Row(
                            children: [
                              SizedBox(
                                width: 200,
                                child: InputDatePickerFormField(
                                  firstDate: DateTime.utc(2024, 01, 01), 
                                  lastDate: DateTime.now(),
                                  fieldLabelText: "Check Out Date",
                              
                                ),
                              ),
                            ],
                          ),
          
                          Row(
                            children: [
                              SizedBox(
                                width: 200,
                                child: InputDatePickerFormField(
                                firstDate: DateTime.utc(2024, 01, 01),
                                 lastDate: DateTime.now(),
                                 fieldLabelText: "Return by",
                              
                                ),
                              ),
                            ],
                          ),
                        ],
                        
                      ),
        ),
                  ),
  ],
),
const Column(
//Fill with Asset selection
),

              Row(
                children: [
                  const Spacer(),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
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
                      child: const Text('Cancel'),
                    ),
                  ),
                      //Remove elevated button below after checking
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Printed!'),
                          ));
                          FirestoreStorage().getAsset(serialNum);
                        }
                      },
                      child: const Text('Submit'),
                                        ),
                    ),
                ],
              )
            ]
            ), 
        
    )
    );

}
}