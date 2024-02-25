import 'package:flutter/material.dart';
import '../models/check_out_model.dart';
import '../models/tableable.dart';


class ReportsPage extends StatefulWidget {
const ReportsPage({super.key});

@override
  // ignore: library_private_types_in_public_api
  _ReportsPage createState() => _ReportsPage(); 
}
class _ReportsPage extends State<ReportsPage>{


final _reports = [
CheckedOut(name: 'Dan', email: 'dan@oc.edu', schoolId: 234897, asset: 'Laptop')
];

// ignore: unused_field
List<Tableable> _filtered = [];
@override
initState() {
  _filtered = _reports;
  super.initState();
}

void _filter(String enteredKeyword) {
  if (enteredKeyword.isEmpty) {
    _filtered = _reports;
  } else {
    _filtered = _reports
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
          padding: const EdgeInsets.all(15.0),
            child: ListView(
              children: [
                Column(
                  children: [
                    const Text("    Reports ", style: TextStyle( fontSize: 20.0)),
                    Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                                 Padding(
                                   padding: const EdgeInsets.all(10.0),
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
                    ] ),
                    const SizedBox(height: 10,),
                      Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 80,
                            child: Card(
                              color: Colors.white,
                             child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const Expanded(
                                    child: ListTile(
                                      leading: Icon(Icons.print),
                                      title: Text('Current Checked-Out Devices', style: TextStyle(color: Color.fromARGB(199, 108, 13, 13), fontSize: 18.0),),
                                      //subtitle: Text(''),
                                    ),
                                  ),
                                      SizedBox(
                                        width: 200,
                                        child: TextButton(
                                          style: const ButtonStyle(
                                            //shadowColor: MaterialStatePropertyAll(Color.fromARGB(199, 108, 13, 13)),
                                          ),
                                          child: const Text('Print/Save PDF', style: TextStyle(color: Color.fromARGB(199, 108, 13, 13), fontSize: 18.0),),
                                          onPressed: () {/* ... */},
                                        ),
                                      ),
                                    ],
                            )
                           ),
                          ),
                        )
                      ],
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 80,
                            child: Card(
                              color: Colors.white,
                             child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const Expanded(
                                    child: ListTile(
                                      leading: Icon(Icons.print),
                                      title: Text("Asset's Purchased", style: TextStyle(color: Color.fromARGB(199, 108, 13, 13), fontSize: 18.0),),
                                      //subtitle: Text(''),
                                    ),
                                  ),
                                      SizedBox(
                                        width: 200,
                                        child: TextButton(
                                          style: const ButtonStyle(
                                            //shadowColor: MaterialStatePropertyAll(Color.fromARGB(199, 108, 13, 13)),
                                          ),
                                          child: const Text('Print/Save PDF', style: TextStyle(color: Color.fromARGB(199, 108, 13, 13), fontSize: 18.0),),
                                          onPressed: () {/* ... */},
                                        ),
                                      ),
                                    ],
                            )
                           ),
                          ),
                        )
                      ],
                    ),
                  
                    ],
                  ) ],
                ),
            
            ),

      );
}


}



  



