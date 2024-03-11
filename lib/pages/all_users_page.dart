import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ocassetmanagement/services/firestore_storage.dart';
import 'package:ocassetmanagement/utils/string_validator.dart';

import '../models/user_group_model.dart';
import 'package:provider/provider.dart';

import '../models/tableable.dart';
import '../models/user_model.dart';
import '../view_models/create_check_out.dart';
import '../widgets/data_table.dart';


class AllUsersPage extends StatefulWidget {
  const AllUsersPage({Key? key}) : super(key: key);

  @override
  _AllUsersPageState createState() => _AllUsersPageState();
}

class _AllUsersPageState extends State<AllUsersPage> {
  late Future<List<User>> _userListFuture;
  late Future<List<UserGroup>> _userGroupsFuture;
  final _formKey = GlobalKey<FormState>();

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
=======
//final _userListFuture = FirestoreStorage().getUsers();

class AllUsersPage extends StatefulWidget {
  const AllUsersPage({super.key});

  @override
  State<AllUsersPage> createState() => _AllUsersPageState();
}



class _AllUsersPageState extends State<AllUsersPage> 
      with WidgetsBindingObserver {
  late Future<List<User>> _userListFuture = FirestoreStorage().getUsers();


void _refreshUsers() {
    setState(() {
      _userListFuture = FirestoreStorage().getUsers();
    });
  }

// late List<User> _filtered = _userListFuture as List<User>;



//   void _filter(String enteredKeyword, DocumentSnapshot? snapshot) {
//   if (enteredKeyword.isEmpty) {
//     _filtered =  snapshot?.data() as List<User>;
//   } else {
//     _filtered = List<User> (snapshot?.data()) 
//     !.where((row) => 
//     row.asRow().any((cell) => 
//     cell?.toString().toLowerCase().contains(enteredKeyword.toLowerCase()) ?? false))
//     .toList();
//   }
 
// }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: FutureBuilder<List<User>>(
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
                      const Text("Users", style: TextStyle( fontSize: 30.0), textAlign: TextAlign.center,),
                Row(
                children: [
                             Padding(
                               padding: const EdgeInsets.only(bottom: 22.0, left: 20),
                               child: SizedBox(
                                width: 200,
                                child: TextField(
                                  onChanged: (value) => setState(() {
                                   // _filter(value);
                                  }
                                  ),
                                  decoration: const InputDecoration(
                                    labelText: 'Search', suffixIcon: Icon(Icons.search),
                                  ),
                                ),
                                                               ),
                             ),
                const Spacer(),
                SizedBox(
                            width: 50,
                            child: IconButton(
                                onPressed: (){
                          final notifier = Provider.of<CreateCheckOutNotifier>(context, listen: false);
                                notifier.newCheckOutScreen(asset: null);
                                }, 
                              icon: const Icon(Icons.add, color: Colors.white,), 
                              //label: const Text("", style: TextStyle(color: Colors.white)),
                              style: IconButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 76, 200, 63),
                                //textStyle: const TextStyle(color: Colors.white),
                              )),
                                ), 
                ]
                ),
                       Row(
                         children: [
                           Expanded(
                            flex: 4,
                             child: AssetDataTable(data: snapshot.data!, 
                             onViewMore: (user ) => _viewMoreInfo(context, user as User), 
                             onEdit: (user ) => _editUser(context, user as User),
                             ),
                           ),
                         ],
                       ),
                       ],
              )
            )
            );
          }
        },
      ),
    );
  }

  void _viewMoreInfo(BuildContext context, User user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('User Details'),
          content: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width * 0.3),
            child: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  _buildDetailRow('School Id:', user.schoolId.toString()),
                  _buildDetailRow('Name:', user.name),
                  _buildDetailRow('Email:', user.email),
                  _buildDetailRow('User Group:', user.userGroup),
                ]
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              // ignore: sort_child_properties_last
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(199, 108, 13, 13),
                  foregroundColor: Colors.white),
            ),
          ],
        );
      },
    );
  }

  void _updateAsset(
      String userId,
      int schoolId,
      String name,
      String email,
      String userGroup,
      ) {
    FirestoreStorage().updateAsset(userId, {
      'userSchoolId': schoolId,
      'userName': name,
      'userEmail': email,
      'userGroup': userGroup,
    }).then((_) {
      _refreshUsers();
      return "Success";
    }).catchError((error) {
      return "$error occurred while updating";
    });
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          text: '$label ',
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
          children: <TextSpan>[
            TextSpan(
                text: value,
                style: const TextStyle(
                    fontWeight: FontWeight.normal, fontSize: 16)),
          ],
        ),
      ),
    );
  }

  void _editUser(BuildContext context, User user) {
    // ignore: no_leading_underscores_for_local_identifiers
    final _formKey = GlobalKey<FormState>();
    final TextEditingController schoolIdController =
        TextEditingController(text: user.schoolId.toString());
    final TextEditingController nameController =
        TextEditingController(text: user.name);
    final TextEditingController emailController =
        TextEditingController(text: user.email);

      String userGroup = user.userGroup;
   

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Asset'),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: ListBody(
                  children: <Widget>[
                    TextFormField(
                      controller: schoolIdController,
                      decoration: const InputDecoration(labelText: 'School Id'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a schoolId';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: nameController,
                      decoration:
                          const InputDecoration(labelText: 'Name'),
                      // Add validator if needed
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                          labelText: 'Email'),
                      // Add validator if needed
                    ),
                    DropdownButtonFormField<String>(
                      value: userGroup,
                      items: User.userGroupOptions
                      .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        userGroup = newValue!;
                      },
                      decoration: const InputDecoration(labelText: 'User Group'),
                    ),
                    
                    // Add other fields as necessary
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                _refreshUsers();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              // ignore: sort_child_properties_last
              child: const Text('Save'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _updateAsset(
                    user.userId,
                    int.parse(schoolIdController.text),
                    nameController.text,
                    userGroup,
                    emailController.text,
                  );
                  _refreshUsers();
                  Navigator.of(context).pop();
                }
              },
              style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(199, 108, 13, 13),
                  foregroundColor: Colors.white),
            ),
          ],
        );
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(labelText: 'Email'),
                        validator: validateEmailAddress,
                      ),
                      TextFormField(
                        controller: idNumberController,
                        decoration:
                            const InputDecoration(labelText: 'ID Number'),
                        validator: validateSchoolID,
                        keyboardType: TextInputType.number,
                      ),
                      TextFormField(
                        controller: firstNameController,
                        decoration:
                            const InputDecoration(labelText: 'First Name'),
                      ),
                      TextFormField(
                        controller: lastNameController,
                        decoration:
                            const InputDecoration(labelText: 'Last Name'),
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
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      User newUser = User();
                      newUser.email = emailController.text;
                      newUser.name =
                          '${firstNameController.text} ${lastNameController.text}';
                      newUser.schoolId = int.parse(idNumberController.text);
                      newUser.userGroup = selectedUserGroup?.name ?? 'IT';
                      await addUser(newUser);
                      setState(() {});
                      Navigator.of(context).pop();
                    }
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
