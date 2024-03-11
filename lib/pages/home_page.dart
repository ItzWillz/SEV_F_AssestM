import 'package:flutter/material.dart';
import 'package:ocassetmanagement/models/asset_instance.dart';

import '../widgets/data_table.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
              child: ListView(
                children:[
                    const Text("    Overdue Check-Outs ", style: TextStyle( fontSize: 20.0)),
                    //AssetDataTable(data: _assetByUserGroup), //${userGroup}
                ]
            ),
       )
    );
  }
}

final _assetByUserGroup = [
   AssetInstance(), //Trying to call fake data
];
