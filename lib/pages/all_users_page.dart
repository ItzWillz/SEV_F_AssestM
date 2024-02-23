import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../widgets/data_table.dart';

class AllUsersPage extends StatelessWidget {
  const AllUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
       child: Padding(
            padding: const EdgeInsets.all(10.0),
              child: ListView(
                children:[
                    Text("    Users", style: TextStyle( fontSize: 20.0)),
                    AssetDataTable(data: _admins), //${userGroup}
                ]
            ),
       )
    );
  }
}

final _admins = [
  User(
      name: 'Dan', email: 'dan@oc.edu', schoolId: 234897, userGroup: 'Admin'),
  User(
      name: 'WIll', email: 'will@oc.edu', schoolId: 2348973, userGroup: 'IT'),
  User(
      name: 'WIll', email: 'will@oc.edu', schoolId: 2348973, userGroup: 'IT'),
  User(
      name: 'WIll', email: 'will@oc.edu', schoolId: 2348973, userGroup: 'IT'),
  User(
      name: 'WIll', email: 'will@oc.edu', schoolId: 2348973, userGroup: 'IT'),
  User(
      name: 'WIll', email: 'will@oc.edu', schoolId: 2348973, userGroup: 'IT'),
  User(
      name: 'WIll', email: 'will@oc.edu', schoolId: 2348973, userGroup: 'IT'),
  User(
      name: 'WIll', email: 'will@oc.edu', schoolId: 2348973, userGroup: 'IT'),
  User(
      name: 'WIll', email: 'will@oc.edu', schoolId: 2348973, userGroup: 'IT'),
  User(
      name: 'WIll', email: 'will@oc.edu', schoolId: 2348973, userGroup: 'IT'),
  User(
      name: 'WIll', email: 'will@oc.edu', schoolId: 2348973, userGroup: 'IT'),
  User(
      name: 'WIll', email: 'will@oc.edu', schoolId: 2348973, userGroup: 'IT'),
  User(
      name: 'WIll', email: 'will@oc.edu', schoolId: 2348973, userGroup: 'IT'),
  User(
      name: 'WIll', email: 'will@oc.edu', schoolId: 2348973, userGroup: 'IT'),
  User(
      name: 'WIll', email: 'will@oc.edu', schoolId: 2348973, userGroup: 'IT'),
  User(
      name: 'WIll', email: 'will@oc.edu', schoolId: 2348973, userGroup: 'IT'),
  User(
      name: 'WIll', email: 'will@oc.edu', schoolId: 2348973, userGroup: 'IT'),
  User(
      name: 'Andrew',
      email: 'andrew@oc.edu',
      schoolId: 248973,
      userGroup: 'Maintenance'),
];
