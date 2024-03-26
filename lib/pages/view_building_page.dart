
import 'package:flutter/material.dart';
import 'package:ocassetmanagement/models/building_model.dart';
import 'package:provider/provider.dart';

import '../models/room_model.dart';
import '../models/tableable.dart';
import '../services/firestore_storage.dart';
import '../view_models/create_new_screen.dart';
import '../widgets/data_table.dart';


class ViewBuildingPage extends StatefulWidget {

ViewBuildingPage({super.key, required this.building, required this.isReadOnly});
final Building? building;
late  bool isReadOnly;
@override
  // ignore: library_private_types_in_public_api
  _ViewBuildingPageState createState() => _ViewBuildingPageState(); 
}
class _ViewBuildingPageState extends State<ViewBuildingPage>{

// ignore: unused_field
@override
initState() {
  super.initState();
}

 static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Info'),
    Tab(text: 'Rooms'),
    Tab(text: "HVAC"),
    Tab(text: "Assets"), 

  ];
  

  @override
Widget build(BuildContext context) {
  print("in the page");
     print(widget.building!.name);
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          leading: SizedBox(
                      width: 100,
                      child: 
                      IconButton(onPressed: () {
                        dispose();
                      } , icon: const Icon(Icons.arrow_back))),
          title:  Text(widget.building!.name), //Text("View Building"), //Text(building.name),
          bottom: const TabBar(
            tabs: myTabs,
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            //final String label = tab.text!.toLowerCase();
             Padding(
          padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: [
              Row(
                children: [
                const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: SizedBox(
                              width: 50,
                              child: IconButton(
                                  onPressed: (){
                            // final notifier = Provider.of<CreateNewScreenNotifier>(context, listen: false);
                            //       notifier.buildingScreen();
                                     widget.isReadOnly = false;
                                  }, 
                                icon: const Icon(Icons.edit, color: Colors.black,), 
                                style: IconButton.styleFrom(
                                  //backgroundColor: const Color.fromARGB(255, 76, 200, 63),
                                )),
                                  ),
                  ),        
                ] ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      width: 200,
                      child: TextFormField(
                        readOnly: widget.isReadOnly, 
                      decoration: const InputDecoration(
                            labelText: 'Building Name',
                        ), 
                      //controller: _profileNameController,

                        initialValue: widget.building?.name,
                        ),
                    ),
                     Container(
                      padding: const EdgeInsets.all(20),
                      width: 200,
                      child: TextFormField(
                        readOnly: widget.isReadOnly, 
                      decoration: const InputDecoration(
                            labelText: 'Building Name',
                        ), 
                        initialValue: widget.building?.name,
                        ),
                    )
                
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      width: 200,
                      child: TextFormField(
                        readOnly: true, 
                      decoration: const InputDecoration(
                            labelText: 'Building Name',
                        ), 
                        initialValue: widget.building?.name,
                        ),
                    )
                
                  ],
                ),
              ]
            )
            ),
             Padding(
               padding: const EdgeInsets.all(10.0),
               child: ListView(
                children: [
                  Row(
                      children: [
                                Padding(
                                 padding: const EdgeInsets.only(bottom: 22.0, left: 20),
                                 child: SizedBox(
                                  width: 200,
                                  child: TextField(
                                    onChanged: (value) => setState(() {
                                     // _filter(value);
                                    }
                                    ),
                                    decoration: const InputDecoration(
                                      labelText: 'Search', suffixIcon: Icon(Icons.search),
                                    ),
                                  ),
                                ),
                               ),
                ],
                ),
                AssetDataTable(data: widget.building!.rooms, 
                    onViewMore: (room ) => _viewInfoRoom(context, room as Room), 
                    onEdit: (room ) => _editRoom(context, room as Room)),
                    ],
                ),
             ),


            //TODO add tabs for HAVC and ASSET lists


          ]),
        ),
      );
   
}

void _viewInfoRoom(BuildContext context, Room room) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Room Details'),
          content: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width * 0.3),
            child: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  _buildDetailRow('Room Number:', room.roomNum.toString()),
                ]
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              // ignore: sort_child_properties_last
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(199, 108, 13, 13),
                  foregroundColor: Colors.white),
            ),
          ],
        );
      },
    );
  }

  // void _updateVendor(
  //     Vendor vendor,
  //     String vendorId,
  //     String vendorName,
  //     String vendorType,
  //     ) {
  //   FirestoreStorage().updateVendor(vendor, {
  //     'vendorName': vendorName,
  //     'vendorType': vendorType,
  //   }).then((_) {
  //     _refreshVendors();
  //     return "Success";
  //   }).catchError((error) {
  //     return "$error occurred while updating";
  //   });
  // }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          text: '$label ',
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
          children: <TextSpan>[
            TextSpan(
                text: value,
                style: const TextStyle(
                    fontWeight: FontWeight.normal, fontSize: 16)),
          ],
        ),
      ),
    );
  }

  void _editRoom(BuildContext context, Room room) {
    // ignore: no_leading_underscores_for_local_identifiers
    final _formKey = GlobalKey<FormState>();
    final TextEditingController nameController =
        TextEditingController(text: room.roomNum.toString());
   

  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Edit Asset'),
  //         content: Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: SingleChildScrollView(
  //             child: Form(
  //               key: _formKey,
  //               child: ListBody(
  //                 children: <Widget>[
  //                   TextFormField(
  //                     controller: nameController,
  //                     decoration: const InputDecoration(labelText: 'Vendor Name'),
  //                     validator: (value) {
  //                       if (value == null || value.isEmpty) {
  //                         return 'Please enter a Vendor Name';
  //                       }
  //                       return null;
  //                     },
  //                   ),
  //                   TextFormField(
  //                     controller: typeController,
  //                     decoration:
  //                         const InputDecoration(labelText: 'Type'),
  //                     // Add validator if needed
  //                   ),
  //                   // Add other fields as necessary
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('Cancel'),
  //             onPressed: () {
  //               _refreshVendors();
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //           TextButton(
  //             // ignore: sort_child_properties_last
  //             child: const Text('Save'),
  //             onPressed: () {
  //               if (_formKey.currentState!.validate()) {
  //                 _updateVendor(
  //                   vendor,
  //                   vendor.vendorId,
  //                   nameController.text,
  //                   typeController.text,
  //                 );
  //                 _refreshVendors();
  //                 Navigator.of(context).pop();
  //               }
  //             },
  //             style: TextButton.styleFrom(
  //                 backgroundColor: const Color.fromARGB(199, 108, 13, 13),
  //                 foregroundColor: Colors.white),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
  }
   
  
  void _editBuilding(BuildContext context, Building building) {
final notifier = Provider.of<CreateNewScreenNotifier>(context, listen: false);
      notifier.buildingScreen(building: building);

 
  }




}