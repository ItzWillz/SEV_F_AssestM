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

final firestoreStorage = FirestoreStorage();

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
    final notifier =
        Provider.of<CreateCheckOutNotifier>(context, listen: false);
    notifier.completeAssetCheckOutSelectScreen();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getPeopleAndBuildings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Use the results from the futures here.
            if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              return Material(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(children: [
                  const Text(
                    "Check Out Device Form",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
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
                                const Text(
                                  "Check-Out Details",
                                  style: TextStyle(fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      width: 200,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Person Name',
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 200,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Person Email',
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 200,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Person School ID',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
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
                                        },
                                        items: const [
                                          // TODO: Display lastName, firstName, schoolID of all people
                                          DropdownMenuItem(
                                              value: "Person",
                                              child: Text("Person")),
                                        ],
                                        onChanged: (String? value) {},
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
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
                                        },
                                        items: const [
                                          // TODO: Display all building names
                                          DropdownMenuItem(
                                              child: Text("Building"),
                                              value: "Building"),
                                        ],
                                        onChanged: (String? value) {},
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
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
                                        },
                                        items: const [
                                          // TODO: Display all rooms that are in the currently selected building
                                          // ignore: sort_child_properties_last
                                          DropdownMenuItem(
                                              child: Text("Room"),
                                              value: "Room"),
                                        ],
                                        onChanged: (String? value) {},
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
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
                                const SizedBox(
                                  height: 20,
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
                            const SizedBox(
                              width: 300,
                            ),
                            Column(
                              //Fill with Asset selection
                              children: [
                                const Text(
                                  "Select Asset to Check-Out",
                                  style: TextStyle(fontSize: 18),
                                ),
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
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                  )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {
                            //Route back to checked out list
                            dispose();
                          },
                          child: const Text('Cancel'),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      //Remove elevated button below after checking
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
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
                ]),
              ));
            }
          } else {
            // While waiting for the futures to complete, you can show a loading indicator or placeholder.
            return CircularProgressIndicator();
          }
        });
  }

  Future<void> getPeopleAndBuildings() async {
    FirestoreStorage firestoreStorage = FirestoreStorage();
    var snapshot = await Future.wait(
        [firestoreStorage.getPeople(), firestoreStorage.getBuildings()]);
    if (snapshot != null) {
      // Extract list of people.
      //print(snapshot[0][0].asRow()));

      // Extract list of buildings
      print(snapshot[1]);
    }
  }
}
