import 'dart:html';

import 'package:flutter/material.dart';
// import 'package:reflectable/reflectable.dart';
// import 'main.reflectable.dart';

/// Flutter code sample for [PaginatedDataTable].

class MyDataSource extends DataTableSource {
  @override
  int get rowCount => admins.length;

  @override
  DataRow? getRow(int index) {
    final row = admins[index];
    return DataRow(cells: [
      DataCell(Text(row.name)),
      DataCell(Text(row.email)),
      DataCell(
        DropdownButton<String>(
          value: row.userGroup,
          items: <String>[
            'Admin',
            'IT',
            'Support Central',
            'Maintenance',
          ].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              row.userGroup = value;
              notifyListeners();
            }
          },
        ),
      ),
      DataCell(Text(row.schoolId)),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

final DataTableSource dataSource = MyDataSource();

class AssetDataTable extends StatelessWidget {
  const AssetDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
      columns: Admin.toDataColumn(),
      source: dataSource,
    );
  }
}

final admins = [
  Admin(
      name: 'Dan', email: 'dan@oc.edu', schoolId: '234897', userGroup: 'Admin'),
  Admin(
      name: 'WIll', email: 'will@oc.edu', schoolId: '2348973', userGroup: 'IT'),
  Admin(
      name: 'WIll', email: 'will@oc.edu', schoolId: '2348973', userGroup: 'IT'),
  Admin(
      name: 'WIll', email: 'will@oc.edu', schoolId: '2348973', userGroup: 'IT'),
  Admin(
      name: 'WIll', email: 'will@oc.edu', schoolId: '2348973', userGroup: 'IT'),
  Admin(
      name: 'WIll', email: 'will@oc.edu', schoolId: '2348973', userGroup: 'IT'),
  Admin(
      name: 'WIll', email: 'will@oc.edu', schoolId: '2348973', userGroup: 'IT'),
  Admin(
      name: 'WIll', email: 'will@oc.edu', schoolId: '2348973', userGroup: 'IT'),
  Admin(
      name: 'WIll', email: 'will@oc.edu', schoolId: '2348973', userGroup: 'IT'),
  Admin(
      name: 'WIll', email: 'will@oc.edu', schoolId: '2348973', userGroup: 'IT'),
  Admin(
      name: 'WIll', email: 'will@oc.edu', schoolId: '2348973', userGroup: 'IT'),
  Admin(
      name: 'WIll', email: 'will@oc.edu', schoolId: '2348973', userGroup: 'IT'),
  Admin(
      name: 'WIll', email: 'will@oc.edu', schoolId: '2348973', userGroup: 'IT'),
  Admin(
      name: 'WIll', email: 'will@oc.edu', schoolId: '2348973', userGroup: 'IT'),
  Admin(
      name: 'WIll', email: 'will@oc.edu', schoolId: '2348973', userGroup: 'IT'),
  Admin(
      name: 'WIll', email: 'will@oc.edu', schoolId: '2348973', userGroup: 'IT'),
  Admin(
      name: 'WIll', email: 'will@oc.edu', schoolId: '2348973', userGroup: 'IT'),
  Admin(
      name: 'Andrew',
      email: 'andrew@oc.edu',
      schoolId: '248973',
      userGroup: 'Maintenance'),
];

class Admin {
  Admin(
      {required this.name,
      required this.email,
      required this.schoolId,
      required this.userGroup});

  static const columns = {'name': 'Name'};

  String name;
  String email;
  String schoolId;
  String userGroup;

  static List<DataColumn> toDataColumn() => [
        'Name',
        'Email',
        'User Group',
        'School ID'
      ].map<DataColumn>((label) => DataColumn(label: Text(label))).toList();

  DataRow? toDataRow() {
    return DataRow(cells: [
      DataCell(Text(name)),
      DataCell(Text(email)),
      DataCell(
        DropdownButton<String>(
          value: userGroup,
          items: <String>[
            'Admin',
            'IT',
            'Support Central',
            'Maintenance',
          ].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              userGroup = value;
            }
          },
        ),
      ),
      DataCell(Text(schoolId)),
    ]);
  }

  //   DataColumn(
  //     label: Text(),
  //   ),
  //   DataColumn(
  //     label: Text(),
  //   ),
  //   DataColumn(
  //     label: Text(),
  //   ),
  // ];
}
