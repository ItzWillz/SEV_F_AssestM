import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/create_check_out.dart';
import '/services/firestore_storage.dart';
import '/models/asset_instance.dart';

final _formKey = GlobalKey<FormState>();
String description = "";
int serialNum = 0;
String wirelessNIC = "";
AssetInstance newAsset = AssetInstance();

class NewCheckOutPage extends StatefulWidget {
const NewCheckOutPage({super.key, this.asset});
final Object? asset;

  @override
  State<NewCheckOutPage> createState() => _NewCheckOutPageState();
}

class _NewCheckOutPageState extends State<NewCheckOutPage> {


 @override
  void dispose() {
    // implement dispose
    final notifier = Provider.of<CreateCheckOutNotifier>(context, listen: false);
    notifier.completeAssetCheckOutSelectScreen();
    super.dispose();
  }

@override
Widget build(BuildContext context) {
return Material(
child: Padding(
  padding: const EdgeInsets.all(8.0),
  child: ListView(
  children: [
  const Text("Check Out Device Form", style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),
  const SizedBox(height: 30,),

  Form(
    key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                const Text("Check-Out Details", style: TextStyle(fontSize: 18),),
                const SizedBox(height: 10,),
  
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
                                       DropdownMenuItem(value: "Person", child: Text("Person")),
                                      ], onChanged: (String? value) {  },
                                    ),
                                  ),
                      ],
                    ),
                    const SizedBox(height: 20,),
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
                                       DropdownMenuItem(child: Text("Building"),value: "Building"),
                                      ], onChanged: (String? value) {  },
                                    ),
                                  ),
                                ],
                              ),
                            
                            const SizedBox(height: 20,),
  
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
                            const SizedBox(height: 20,),
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
                           const SizedBox(height: 20,),
  
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
                  const SizedBox(width: 300,),
                 Column(
                  //Fill with Asset selection
                  children: [ 
                    const Text("Select Asset to Check-Out", style: TextStyle(fontSize: 18),),
                    SizedBox(
                      width: 300,
                      height: 370,
                      child: Card(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton.icon(
                                icon: const Icon(Icons.add),
                                label: const Text("Select Asset"),
                                onPressed: () {
                                  
                                },),
                            ],
                          ),
                        )
                                    ),
                    ),
                  
                  
                  
                  ],
          
          
          
                  ),
          
            ],
          ),
        ),
      ),
                ),
                      const SizedBox(height: 80,),

  
                Row(
                  children: [
                    const Spacer(),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () { //Route back to checked out list
                        dispose();
                        },
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 20,),
                        //Remove elevated button below after checking
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Asset Attached'),
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