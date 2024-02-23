import 'package:flutter/material.dart';
import 'package:ocassetmanagement/services/firestore_storage.dart';

import '../models/user_model.dart';
import '../widgets/data_table.dart';

final _userListFuture = FirestoreStorage().getUsers();

class AllUsersPage extends StatelessWidget {
  const AllUsersPage({super.key});

  // Future Builder Way
  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder<List<User>>(
      future: _userListFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While the future is still running, show a loading indicator or placeholder
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // If there's an error, display an error message
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // If there's no data or the data is empty, display a message
          return const Text('No users found.');
        } else {
          // If the data is available, build your UI with the data
          return Material(
            child: Padding(
            padding: const EdgeInsets.all(10.0),
              child: ListView(
                children:[
                    Text("    Users", style: TextStyle( fontSize: 20.0)),
                     AssetDataTable(data: snapshot.data!),
                     ],
            )
          )
          );
        }
      },
    );
  }
}

// Fake Data for testing
// final _admins = [
//   User(
//       name: 'Dan', email: 'dan@oc.edu', schoolId: 234897, userGroup: 'Admin'),
//   User(
//       name: 'WIll', email: 'will@oc.edu', schoolId: 2348973, userGroup: 'IT'),
//   User(
//       name: 'WIll', email: 'will@oc.edu', schoolId: 2348973, userGroup: 'IT'),
//   User(
//       name: 'WIll', email: 'will@oc.edu', schoolId: 2348973, userGroup: 'IT'),
//   User(
//       name: 'WIll', email: 'will@oc.edu', schoolId: 2348973, userGroup: 'IT'),
//   User(
//       name: 'WIll', email: 'will@oc.edu', schoolId: 2348973, userGroup: 'IT'),
//   User(
//       name: 'WIll', email: 'will@oc.edu', schoolId: 2348973, userGroup: 'IT'),
//   User(
//       name: 'WIll', email: 'will@oc.edu', schoolId: 2348973, userGroup: 'IT'),
//   User(
//       name: 'WIll', email: 'will@oc.edu', schoolId: 2348973, userGroup: 'IT'),
//   User(
//       name: 'WIll', email: 'will@oc.edu', schoolId: 2348973, userGroup: 'IT'),
//   User(
//       name: 'WIll', email: 'will@oc.edu', schoolId: 2348973, userGroup: 'IT'),
//   User(
//       name: 'WIll', email: 'will@oc.edu', schoolId: 2348973, userGroup: 'IT'),
//   User(
//       name: 'WIll', email: 'will@oc.edu', schoolId: 2348973, userGroup: 'IT'),
//   User(
//       name: 'WIll', email: 'will@oc.edu', schoolId: 2348973, userGroup: 'IT'),
//   User(
//       name: 'WIll', email: 'will@oc.edu', schoolId: 2348973, userGroup: 'IT'),
//   User(
//       name: 'WIll', email: 'will@oc.edu', schoolId: 2348973, userGroup: 'IT'),
//   User(
//       name: 'WIll', email: 'will@oc.edu', schoolId: 2348973, userGroup: 'IT'),
//   User(
//       name: 'Andrew',
//       email: 'andrew@oc.edu',
//       schoolId: 248973,
//       userGroup: 'Maintenance'),
// ];
