import 'package:flutter/material.dart';
// ignore: unused_import
import '../models/asset_instance.dart';

import '../models/reservation_model.dart';
import '../widgets/data_table.dart';

class ReservationsPage extends StatelessWidget {
  const ReservationsPage({super.key});

  @override
  Widget build(BuildContext context) {
     return Material(
           child: Padding(
            padding: const EdgeInsets.all(10.0),
              child: ListView(
                children:[
                    const Text("    Reservations", style: TextStyle( fontSize: 20.0)),
                    AssetDataTable(data: _reservations, onViewMore: (Object ) {  }, onEdit: (Object ) {  },), //${userGroup}
                ]
            ),
       )
    );
  }
}

final _reservations = [
  Reservations(name: 'Dan', email: 'dan@oc.edu', schoolId: 234897, assetType: 'Laptop')
];
