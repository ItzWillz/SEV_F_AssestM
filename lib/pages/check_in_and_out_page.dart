import 'package:flutter/material.dart';
import 'package:ocassetmanagement/pages/new_check_out_page.dart';
import '../models/asset_instance.dart';

import '../models/check_out_model.dart';
import '../models/reservation_model.dart';
import '../widgets/data_table.dart';

class CheckInandOutPage extends StatelessWidget {
  const CheckInandOutPage({super.key});

  @override
  Widget build(BuildContext context) {
     return Material(
           child: Padding(
            padding: const EdgeInsets.all(10.0),
              
              child: ListView(
                children: [
                  Column(
                    
                    children: [
                      Row(
                    //mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 1198,
                            height: 650,
                            child: ListView(
                              children:[
                                  const Text("    Checked Out Assets ", style: TextStyle( fontSize: 20.0)),
                                  AssetDataTable(data: _checkedOut), 
                                  
                              ]
                            ),
                          ),
                        ],
                      ),
                   Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    // mainAxisSize: MainAxisSize.max,
                     children: [
                      Spacer(),
                       SizedBox(
                                 width: 200,
                                  child: ElevatedButton.icon(
                                      onPressed: (){
                                        Navigator.of(
                                          context
                                        ).push(MaterialPageRoute(builder: (context) => const NewCheckOutPage()));
                                      }, 
                                    icon: Icon(Icons.add), 
                                    label: Text("Add Check-Out"),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.lightGreen,
                                      textStyle: TextStyle(color: Colors.white),
                                    )),
                                      ),
                                  
                                     
                     ] ),
                     ],
                   ) ],
                  ),
              
              ),

       );
  }
}

final _checkedOut = [
  CheckedOut(name: 'Dan', email: 'dan@oc.edu', schoolId: 234897, asset: 'Laptop')
];