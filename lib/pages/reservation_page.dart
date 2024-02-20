import 'package:flutter/material.dart';
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
              child:AssetDataTable(data: _reservations, section: "   Reservations ",),
                ),
    );
  }
}

final _reservations = [
  Reservations(name: 'Dan', email: 'dan@oc.edu', schoolId: 234897, assetType: 'Laptop')
];
