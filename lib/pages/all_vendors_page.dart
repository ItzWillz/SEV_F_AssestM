import 'package:flutter/material.dart';
import 'package:ocassetmanagement/pages/add_vendor_page.dart';
import 'package:ocassetmanagement/services/firestore_storage.dart';
import 'package:ocassetmanagement/view_models/create_new_screen.dart';
import 'package:provider/provider.dart';

import '../models/vendor_model.dart';
import '../widgets/data_table.dart';

final _vendorsListFuture = FirestoreStorage().getVendors();

class AllVendorsPage extends StatefulWidget {
const AllVendorsPage({super.key});

  @override
  State<AllVendorsPage> createState() => _AllVendorsPageState();
}


class _AllVendorsPageState extends State<AllVendorsPage> {
  late Future<List<Vendor>> _vendorsListFuture = FirestoreStorage().getVendors();
 
  void _refreshVendors() {
    setState(() {
      _vendorsListFuture = FirestoreStorage().getVendors();
    });
  }

  void dispose() {
    // implement dispose
    final notifier = Provider.of<CreateNewScreenNotifier>(context, listen: false);
    notifier.completeAllVendorPage();
    super.dispose();
  }
// Future Builder Way
@override
Widget build(BuildContext context) {

  return FutureBuilder<List<Vendor>>(
    future: _vendorsListFuture,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // While the future is still running, show a loading indicator or placeholder
        return const CircularProgressIndicator();
      } else if (snapshot.hasError) {
        print(snapshot);
        // If there's an error, display an error message
        return Text('Error: ${snapshot.error}');
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        print(snapshot.data);
        // If there's no data or the data is empty, display a message
        return const Text('No vendors found.');
      } else {
        print(snapshot.data);
        // If the data is available, build your UI with the data
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
                    
                      const Center(child: const Text("Vendors", style: TextStyle( fontSize: 30.0), textAlign: TextAlign.center,)),
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
                                notifier.newVendor();
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
                    onViewMore: (vendor ) => _viewMoreInfo(context, vendor as Vendor), 
                    onEdit: (vendor ) => _editVendor(context, vendor as Vendor)),
                    ],
          )
        ),
        
        );
      }
    },
  );
}


void _viewMoreInfo(BuildContext context, Vendor vendor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Vendor Details'),
          content: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width * 0.3),
            child: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  _buildDetailRow('Name:', vendor.name),
                  _buildDetailRow('Type:', vendor.type),
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
      String vendorId,
      String name,
      String type,
      ) {
    FirestoreStorage().updateAsset(vendorId, {
      'vendorName': name,
      'vendorType': type,
    }).then((_) {
      _refreshVendors();
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

  void _editVendor(BuildContext context, Vendor vendor) {
    // ignore: no_leading_underscores_for_local_identifiers
    final _formKey = GlobalKey<FormState>();
    final TextEditingController nameController =
        TextEditingController(text: vendor.name);
    final TextEditingController typeController =
        TextEditingController(text: vendor.type);
   

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
                      decoration: const InputDecoration(labelText: 'Vendor Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a Vendor Name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: typeController,
                      decoration:
                          const InputDecoration(labelText: 'Type'),
                      // Add validator if needed
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
                _refreshVendors();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              // ignore: sort_child_properties_last
              child: const Text('Save'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _updateAsset(
                    vendor.vendorId,
                    nameController.text,
                    typeController.text,
                  );
                  _refreshVendors();
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
