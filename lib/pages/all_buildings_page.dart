import 'package:flutter/material.dart';
import 'package:ocassetmanagement/models/building_model.dart';
import 'package:provider/provider.dart';

import '../models/tableable.dart';
import '../widgets/data_table.dart';


class AllBuildingsPage extends StatefulWidget {
const AllBuildingsPage({super.key});

@override
  // ignore: library_private_types_in_public_api
  _AllBuildingsPageState createState() => _AllBuildingsPageState(); 
}
class _AllBuildingsPageState extends State<AllBuildingsPage>{


final _checkedOut = [
Building(name: 'Prince Engineering Center (PEC)', roomNum: 30, assetTotal: 235)
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
                            //final notifier = Provider.of<CreateCheckOutNotifier>(context, listen: false);
                                  //notifier.newCheckOutScreen(asset: null);
                                     
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
                      child: AssetDataTable(data: _filtered), 
                    ),
                  ],
                ) ],
                ),
            
            ),

      );
}


}



  



