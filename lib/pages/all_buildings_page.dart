import 'package:flutter/material.dart';
import 'package:ocassetmanagement/models/building_model.dart';
import 'package:ocassetmanagement/models/room_model.dart';
import 'package:provider/provider.dart';

import '../models/tableable.dart';
import '../services/firestore_storage.dart';
import '../view_models/create_new_screen.dart';
import '../widgets/data_table.dart';


class AllBuildingsPage extends StatefulWidget {
const AllBuildingsPage({super.key, required this.callBack});
final void Function(Building?) callBack;

@override
  // ignore: library_private_types_in_public_api
  _AllBuildingsPageState createState() => _AllBuildingsPageState(); 
}
class _AllBuildingsPageState extends State<AllBuildingsPage>{


final _checkedOut = [
Building(name: 'Prince Engineering Center (PEC)', roomNum: 30, assetTotal: 235, rooms: [Room(roomNum: 205, assets: ["none", "none"]), Room(roomNum: 105, assets: ["none", "none"])], maintenanceNotes: "No maintenance", assets: [])
];

// ignore: unused_field
List<Tableable> _filtered = [];
@override
initState() {
  _filtered = _checkedOut;
  super.initState();
}

void _filter(String enteredKeyword) {
  if (enteredKeyword.isEmpty) {
    _filtered = _checkedOut;
  } else {
    _filtered = _checkedOut
    .where((row) => 
    row.asRow().any((cell) => 
    cell?.toString().toLowerCase().contains(enteredKeyword.toLowerCase()) ?? false))
    .toList();
  }
 
}

  @override
Widget build(BuildContext context) {
    return Material(
          child: Padding(
          padding: const EdgeInsets.all(10.0),
            
            child: ListView(
              children: [
                const Text("    Buildings List ", style: TextStyle( fontSize: 20.0,), textAlign: TextAlign.center,),
                Row(
                children: [
                             Padding(
                               padding: const EdgeInsets.only(bottom: 22.0, left: 20),
                               child: SizedBox(
                                width: 200,
                                child: TextField(
                                  onChanged: (value) => setState(() {
                                    _filter(value);
                                  }
                                  ),
                                  decoration: const InputDecoration(
                                    labelText: 'Search', suffixIcon: Icon(Icons.search),
                                  ),
                                ),
                                                               ),
                             ),
                const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: SizedBox(
                              width: 50,
                              child: IconButton(
                                  onPressed: (){
                            final notifier = Provider.of<CreateNewScreenNotifier>(context, listen: false);
                                  notifier.newBuilding();
                                     
                                  }, 
                                icon: const Icon(Icons.add, color: Colors.white,), 
                                //label: const Text("", style: TextStyle(color: Colors.white)),
                                style: IconButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(255, 76, 200, 63),
                                  //textStyle: const TextStyle(color: Colors.white),
                                )),
                                  ),
                  ),        
                ] ),
                Row(
                  children: [
                    Expanded(
                     flex: 4,
                      child: AssetDataTable(data: _filtered,
                    onViewMore: (building ) => _viewMoreInfo(context, building as Building), 
                    onEdit: (building ) => _editBuilding(context, building as Building)),),
                  ],
                ) ],
                ),
            
            ),

      );
}

void _viewMoreInfo(BuildContext context, Building building) {
    final notifier = Provider.of<CreateNewScreenNotifier>(context, listen: false);
      widget.callBack(building);
      notifier.buildingScreen(building: building);

    
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: const Text('Vendor Details'),
    //       content: ConstrainedBox(
    //         constraints: BoxConstraints(
    //             minWidth: MediaQuery.of(context).size.width * 0.3),
    //         child: SingleChildScrollView(
    //           child: ListBody(
    //             children: <Widget>[
    //               _buildDetailRow('Name:', vendor.name),
    //               _buildDetailRow('Type:', vendor.type),
    //             ]
    //           ),
    //         ),
    //       ),
    //       actions: <Widget>[
    //         TextButton(
    //           // ignore: sort_child_properties_last
    //           child: const Text('Close'),
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //           style: TextButton.styleFrom(
    //               backgroundColor: const Color.fromARGB(199, 108, 13, 13),
    //               foregroundColor: Colors.white),
    //         ),
    //       ],
    //     );
    //   },
    // );


  }

  // void _updateAsset(
  //     String vendorId,
  //     String name,
  //     String type,
  //     ) {
  //   FirestoreStorage().updateAsset(vendorId, {
  //     'vendorName': name,
  //     'vendorType': type,
  //   }).then((_) {
  //     _refreshBuildings();
  //     return "Success";
  //   }).catchError((error) {
  //     return "$error occurred while updating";
  //   });
  // }

  // Widget _buildDetailRow(String label, String value) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 4.0),
  //     child: RichText(
  //       text: TextSpan(
  //         text: '$label ',
  //         style: const TextStyle(
  //             fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
  //         children: <TextSpan>[
  //           TextSpan(
  //               text: value,
  //               style: const TextStyle(
  //                   fontWeight: FontWeight.normal, fontSize: 16)),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  void _editBuilding(BuildContext context, Building building) {
final notifier = Provider.of<CreateNewScreenNotifier>(context, listen: false);
      notifier.buildingScreen(building: building);

    // // ignore: no_leading_underscores_for_local_identifiers
    // final _formKey = GlobalKey<FormState>();
    // final TextEditingController nameController =
    //     TextEditingController(text: vendor.name);
    // final TextEditingController typeController =
    //     TextEditingController(text: vendor.type);
   

    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: const Text('Edit Asset'),
    //       content: Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: SingleChildScrollView(
    //           child: Form(
    //             key: _formKey,
    //             child: ListBody(
    //               children: <Widget>[
    //                 TextFormField(
    //                   controller: nameController,
    //                   decoration: const InputDecoration(labelText: 'Vendor Name'),
    //                   validator: (value) {
    //                     if (value == null || value.isEmpty) {
    //                       return 'Please enter a Vendor Name';
    //                     }
    //                     return null;
    //                   },
    //                 ),
    //                 TextFormField(
    //                   controller: typeController,
    //                   decoration:
    //                       const InputDecoration(labelText: 'Type'),
    //                   // Add validator if needed
    //                 ),
    //                 // Add other fields as necessary
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),
    //       actions: <Widget>[
    //         TextButton(
    //           child: const Text('Cancel'),
    //           onPressed: () {
    //             _refreshVendors();
    //             Navigator.of(context).pop();
    //           },
    //         ),
    //         TextButton(
    //           // ignore: sort_child_properties_last
    //           child: const Text('Save'),
    //           onPressed: () {
    //             if (_formKey.currentState!.validate()) {
    //               _updateAsset(
    //                 vendor.vendorId,
    //                 nameController.text,
    //                 typeController.text,
    //               );
    //               _refreshVendors();
    //               Navigator.of(context).pop();
    //             }
    //           },
    //           style: TextButton.styleFrom(
    //               backgroundColor: const Color.fromARGB(199, 108, 13, 13),
    //               foregroundColor: Colors.white),
    //         ),
    //       ],
    //     );
    //   },
    // );
  }



}



  



