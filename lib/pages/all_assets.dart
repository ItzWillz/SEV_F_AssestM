import 'package:flutter/material.dart';
import 'package:ocassetmanagement/widgets/data_table.dart';
import '../services/firestore_storage.dart';
import '../models/asset_model.dart';

final _assetListFuture = FirestoreStorage().getAssets();

class AllAssetsPage extends StatelessWidget {
  const AllAssetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Assets'),
      ),
      body: FutureBuilder<List<Asset>>(
        future: _assetListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No assets found.'));
          } else {
            return Material(
                child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                children: [
                  const Text("Assets", style: TextStyle(fontSize: 20.0)),
                  AssetDataTable(data: snapshot.data!),
                ],
              ),
            ));
          }
        },
      ),
    );
  }

  // ignore: unused_element
  _viewMoreInfo(BuildContext context, Asset asset) {}

  // ignore: unused_element
  _editAsset(BuildContext context, Asset asset) {}
}
