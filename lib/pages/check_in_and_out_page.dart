import 'package:flutter/material.dart';
import 'package:ocassetmanagement/pages/new_check_out_page.dart';

import '../models/check_out_model.dart';
import '../models/tableable.dart';
import '../widgets/data_table.dart';


class CheckInandOutPage extends StatefulWidget {
const CheckInandOutPage({super.key});

@override
  // ignore: library_private_types_in_public_api
  _CheckInandOutPageState createState() => _CheckInandOutPageState(); 
}
class _CheckInandOutPageState extends State<CheckInandOutPage>{


final _checkedOut = [
CheckedOut(name: 'Dan', email: 'dan@oc.edu', schoolId: 234897, asset: 'Laptop')
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
                Column(
                  
                  children: [
                    const Text("    Checked Out Assets ", style: TextStyle( fontSize: 20.0)),
                    Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  // mainAxisSize: MainAxisSize.max,
                    children: [
                                 SizedBox(
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
                    const Spacer(),
                      SizedBox(
                                width: 200,
                                child: ElevatedButton.icon(
                                    onPressed: (){
                                      Navigator.of(
                                        context
                                      ).push(MaterialPageRoute(builder: (context) => const NewCheckOutPage()));
                                    }, 
                                  icon: const Icon(Icons.add, color: Colors.white,), 
                                  label: const Text("Add Check-Out", style: TextStyle(color: Colors.white)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFB9E2A7),
                                    textStyle: const TextStyle(color: Colors.white),
                                  )),
                                    ),        
                    ] ),
                    Row(
                  //mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 1198,
                          height: 650,
                          child: AssetDataTable(data: _filtered), 
                        ),
                      ],
                    ),
                  
                    ],
                  ) ],
                ),
            
            ),

      );
}


}



  



