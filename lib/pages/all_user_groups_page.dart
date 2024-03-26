import 'package:flutter/material.dart';
import 'package:ocassetmanagement/services/firestore_storage.dart';
import 'package:ocassetmanagement/view_models/create_new_screen.dart';
import 'package:provider/provider.dart';
import '../widgets/data_table.dart';

class AllUserGroupsPage extends StatefulWidget {
const AllUserGroupsPage({super.key});

  @override
  State<AllUserGroupsPage> createState() => _AllUserGroupsPageState();
}


class _AllUserGroupsPageState extends State<AllUserGroupsPage> {
  Future<List<String>> _userGroups = FirestoreStorage().getUserG();
 
  void _refreshUserGroups() {
    setState(() {
      _userGroups = FirestoreStorage().getUserG();
    });
  }

@override
  void dispose() {
    // implement dispose
    final notifier = Provider.of<CreateNewScreenNotifier>(context, listen: false);
    notifier.completeAllUGPage();
    super.dispose();
  }
// Future Builder Way
@override
Widget build(BuildContext context) {
  return FutureBuilder<List<String>>(
    future: _userGroups,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // While the future is still running, show a loading indicator or placeholder
        return const CircularProgressIndicator();
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Text('No User Groups found.');
      } else {
        return Material(
          child: Padding(
          padding: const EdgeInsets.all(10.0),
            child: ListView(
              children:[
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: 
                      IconButton(onPressed: () {
                        dispose();
                      } , icon: const Icon(Icons.arrow_back))),
                    
                      const Center(child: Text("User Groups", style: TextStyle( fontSize: 30.0), textAlign: TextAlign.center,)),
                  ],
                ),
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
                          final notifier = Provider.of<CreateNewScreenNotifier>(context, listen: false);
                                notifier.newUserGroup();
                                }, 
                              icon: const Icon(Icons.add, color: Colors.white,), 
                              //label: const Text("", style: TextStyle(color: Colors.white)),
                              style: IconButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 76, 200, 63),
                                //textStyle: const TextStyle(color: Colors.white),
                              )),
                                ), 
                ],
                  ),
                    AssetDataTable(data: snapshot.data!, 
                    onViewMore: (userG ) => _viewMoreInfo(context, userG as String), 
                    onEdit: (userG ) => _editUserGroup(context, userG as String)),
                    ],
          )
        ),
        
        );
      }
    },
  );
}


void _viewMoreInfo(BuildContext context, String userG) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('User Group Details'),
          content: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width * 0.3),
            child: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  _buildDetailRow('Name:', userG),
                  // Add the Permission listed here
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

  void _updateUserGroup(
      String name,
      ) {
    FirestoreStorage().updateUserGroup(name).then((_) {
      _refreshUserGroups();
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

  void _editUserGroup(BuildContext context, String userG) {
    // ignore: no_leading_underscores_for_local_identifiers
    final _formKey = GlobalKey<FormState>();
    final TextEditingController nameController =
        TextEditingController(text: userG);
   

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
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'User Group Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a User Group Name';
                        }
                        return null;
                      },
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
                _refreshUserGroups();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              // ignore: sort_child_properties_last
              child: const Text('Save'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _updateUserGroup(
                    nameController.text,
                  );
                  _refreshUserGroups();
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
}
