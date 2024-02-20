import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../widgets/data_table.dart';

class AllUsersPage extends StatelessWidget {
  const AllUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(child: AssetDataTable(data: _admins, section: '',));
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
