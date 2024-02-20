import 'package:flutter/material.dart';
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
              child:AssetDataTable(data: _checkedOut, section: "   Checked Out Devices ",),
                ),
    );
  }
}

final _checkedOut = [
  CheckedOut(name: 'Dan', email: 'dan@oc.edu', schoolId: 234897, asset: 'Laptop')
];