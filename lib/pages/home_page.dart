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
              child:AssetDataTable(data: _assetByUserGroup, section: "   Asset's Managed by ",), //${userGroup}
                ),
    );
  }
}

final _assetByUserGroup = [
   AssetInstance(), //Trying to call fake data
];
