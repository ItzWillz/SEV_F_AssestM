import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:ocassetmanagement/services/firestore_storage.dart';

import '../models/user_group_model.dart';
import '../models/user_model.dart';
import '../widgets/data_table.dart';

class AllUsersPage extends StatefulWidget {
  const AllUsersPage({Key? key}) : super(key: key);

  @override
  _AllUsersPageState createState() => _AllUsersPageState();
}

class _AllUsersPageState extends State<AllUsersPage> {
  late Future<List<User>> _userListFuture;
  late Future<List<UserGroup>> _userGroupsFuture;

  @override
  void initState() {
    super.initState();
    _userListFuture = FirestoreStorage().getUsers();
    _userGroupsFuture = FirestoreStorage().getUserGroups();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>>(
      future: _userListFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No users found.');
        } else {
          return FutureBuilder<List<UserGroup>>(
            future: _userGroupsFuture,
            builder: (context, userGroupSnapshot) {
              if (userGroupSnapshot.connectionState ==
                  ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (userGroupSnapshot.hasError) {
                return Text('Error: ${userGroupSnapshot.error}');
              } else if (!userGroupSnapshot.hasData ||
                  userGroupSnapshot.data!.isEmpty) {
                return const Text('No user groups found.');
              } else {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('Users'),
                  ),
                  body: Material(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 22.0, left: 20),
                                child: SizedBox(
                                  width: 200,
                                  child: TextField(
                                    decoration: const InputDecoration(
                                      labelText: 'Search',
                                      prefixIcon: Icon(Icons.search),
                                    ),
                                    onChanged: (value) {
                                      // Filter the data table based on the value entered in the text field
                                      // You can implement filtering logic here
                                    },
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: SizedBox(
                                  width: 50,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      _showAddUserDialog(
                                          context, userGroupSnapshot.data!);
                                    },
                                    style: IconButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255, 76, 200, 63),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: AssetDataTable(data: snapshot.data!),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
          );
        }
      },
    );
  }

  addUser(User user) async {
    await FirestoreStorage().addNewUser(user);
  }

  void _showAddUserDialog(BuildContext context, List<UserGroup> userGroups) {
    TextEditingController emailController = TextEditingController();
    TextEditingController idNumberController = TextEditingController();
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    UserGroup? selectedUserGroup;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Add User'),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                    ),
                    TextFormField(
                        controller: idNumberController,
                        decoration:
                            const InputDecoration(labelText: 'ID Number'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter ID Number';
                          }
                          if (int.tryParse(value) == null) {
                            return 'ID Number must be a valid integer';
                          }
                          return null;
                        }),
                    TextFormField(
                      controller: firstNameController,
                      decoration:
                          const InputDecoration(labelText: 'First Name'),
                    ),
                    TextFormField(
                      controller: lastNameController,
                      decoration: const InputDecoration(labelText: 'Last Name'),
                    ),
                    DropdownButtonFormField<UserGroup>(
                      value: selectedUserGroup,
                      items: userGroups.map((userGroup) {
                        return DropdownMenuItem<UserGroup>(
                          value: userGroup,
                          child: Text(userGroup.name),
                        );
                      }).toList(),
                      onChanged: (userGroup) {
                        setState(() {
                          selectedUserGroup = userGroup;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'User Group',
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    User newUser = User();
                    newUser.email = emailController.text;
                    newUser.name =
                        '${firstNameController.text} ${lastNameController.text}';
                    newUser.schoolId = int.parse(idNumberController.text);
                    newUser.userGroup = selectedUserGroup?.name ?? 'IT';
                    await addUser(newUser);
                    setState(() {});
                    Navigator.of(context).pop();
                  },
                  child: const Text('Submit'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
