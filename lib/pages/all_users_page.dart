import 'package:flutter/material.dart';
import 'package:ocassetmanagement/services/firestore_storage.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../models/user_model.dart';
import '../view_models/create_check_out.dart';
import '../widgets/data_table.dart';

class AllUsersPage extends StatefulWidget {
  const AllUsersPage({super.key});

  @override
  State<AllUsersPage> createState() => _AllUsersPageState();
}

class _AllUsersPageState extends State<AllUsersPage>
    with WidgetsBindingObserver {
  Future<List<User>> _userListFuture = FirestoreStorage().getUsers();
  String _filterCriteria = '';
  final _formKey = GlobalKey<FormState>();
  final schoolIdController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  void _refreshUsers() {
    setState(() {
      _userListFuture = FirestoreStorage().getUsers();
    });
  }

  List<User> _filter(List<User> allUsers) {
    if (_filterCriteria.isEmpty) {
      return allUsers;
    }
    return allUsers
        .where(
          (user) =>
              user.email.contains(_filterCriteria) ||
              user.name.contains(_filterCriteria) ||
              user.schoolId.toString().contains(_filterCriteria),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<User>>(
        future: _userListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No users found.');
          }
          final data = _filter(snapshot.data!);
          return _allUserWithData(context, data);
        },
      ),
    );
  }

  Material _allUserWithData(BuildContext context, List<User> data) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            const Text(
              "Users",
              style: TextStyle(fontSize: 30.0),
              textAlign: TextAlign.center,
            ),
            _actionBar(context),
            AssetDataTable(
              data: data,
              onViewMore: (user) => _viewMoreInfo(context, user as User),
              onEdit: (user) => _editUser(context, user as User),
            ),
          ],
        ),
      ),
    );
  }

  Row _actionBar(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 22.0, left: 20),
          width: 200,
          child: TextField(
            onChanged: (value) => setState(() {
              _filterCriteria = value;
            }),
            decoration: const InputDecoration(
              labelText: 'Search',
              suffixIcon: Icon(Icons.search),
            ),
          ),
        ),
        const Spacer(),
        SizedBox(
          width: 50,
          child: IconButton(
              onPressed: () {
                final notifier =
                    Provider.of<CreateCheckOutNotifier>(context, listen: false);
                notifier.newCheckOutScreen(asset: null);
              },
              icon: const Icon(Icons.add, color: Colors.white),
              style: IconButton.styleFrom(backgroundColor: addGreen)),
        ),
      ],
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
              child: ListBody(children: <Widget>[
                _buildDetailRow('School Id:', user.schoolId.toString()),
                _buildDetailRow('Name:', user.name),
                _buildDetailRow('Email:', user.email),
                _buildDetailRow('User Group:', user.userGroup),
              ]),
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
              style:
                  const TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  void _editUser(BuildContext context, User user) {
    schoolIdController.text = user.schoolId.toString();
    nameController.text = user.name;
    emailController.text = user.email;

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
                      decoration: const InputDecoration(labelText: 'Name'),
                      // Add validator if needed
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
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
                        if (newValue != null) {
                          userGroup = newValue;
                        }
                      },
                      decoration:
                          const InputDecoration(labelText: 'User Group'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
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
                  Navigator.of(context).pop();
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: ocMaroon,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }
}
