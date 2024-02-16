import 'package:flutter/material.dart';

import '../widgets/data_table.dart';

class AllUsersPage extends StatelessWidget {
  const AllUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(child: AssetDataTable());
  }
}