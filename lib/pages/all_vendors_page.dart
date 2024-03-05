import 'package:flutter/material.dart';
import 'package:ocassetmanagement/pages/add_vendor_page.dart';
import 'package:ocassetmanagement/services/firestore_storage.dart';

import '../models/vendor_model.dart';
import '../widgets/data_table.dart';

final _vendorsListFuture = FirestoreStorage().getVendors();

class AllVendorsPage extends StatelessWidget {
const AllVendorsPage({super.key});

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
                  const Text("    Vendors", style: TextStyle( fontSize: 20.0)),
                    VendorDataTable(data: snapshot.data!),
                    ElevatedButton(onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddVendorPage(),
                        ),
                      );
                    }, child: const Text("Add new Vendor"))
                    ],
          )
        ),
        
        );
      }
    },
  );
}
}
