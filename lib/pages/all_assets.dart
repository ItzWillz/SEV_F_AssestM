import 'package:flutter/material.dart';
import 'package:ocassetmanagement/widgets/asset_list_data_table.dart';
import '../services/firestore_storage.dart';
import '../models/asset_model.dart';

final _assetListFuture = FirestoreStorage().getAssets();

class AllAssetsPage extends StatelessWidget {
  const AllAssetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    //FirestoreStorage().insertAsset();
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
            return Center(child: Text('Error is here: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No assets found.'));
          } else {
            return Material(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  children: [
                    AssetListDataTable(
                        data: snapshot.data!,
                        onViewMore: (Asset asset) =>
                            _viewMoreInfo(context, asset),
                        onEdit: (Asset asset) => _editAsset(context, asset)),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  void _viewMoreInfo(BuildContext context, Asset asset) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Asset Details'),
          content: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width * 0.7),
            child: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  _buildDetailRow('Description:', asset.description),
                  _buildDetailRow('Type:', asset.assetType.toString()),
                  _buildDetailRow('Serial Number:', asset.serialNum.toString()),
                  _buildDetailRow('Status:', asset.status),
                  _buildDetailRow(
                      'External Accessories:', asset.externalAccessories),
                  _buildDetailRow('Internal Features:', asset.internalFeatures),
                  _buildDetailRow('Wireless NIC:', asset.wirelessNIC),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _updateAsset(
      String assetId,
      String description,
      String status,
      String type,
      String serialNum,
      String externalAccessories,
      String internalFeatures,
      String wirelessNIC) {
    FirestoreStorage().updateAsset(assetId, {
      'assetProfileId': 2,
      'assetCategoryId': 5,
      'description': description,
      'serialNum': serialNum,
      'status': status,
      'wirelessNIC': wirelessNIC,
      'internalFeatures': internalFeatures,
      'externalAccessories': externalAccessories,
    }).then((_) {
      // Handle successful update, maybe show a success message
    }).catchError((error) {
      // Handle errors, maybe show an error message
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

  void _editAsset(BuildContext context, Asset asset) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _descriptionController =
        TextEditingController(text: asset.description);
    final TextEditingController _serialNumController =
        TextEditingController(text: asset.serialNum.toString());
    final TextEditingController _externalAccessoriesController =
        TextEditingController(text: asset.externalAccessories);
    final TextEditingController _internalFeaturesController =
        TextEditingController(text: asset.internalFeatures);
    final TextEditingController _wirelessNICController =
        TextEditingController(text: asset.wirelessNIC);

    String _selectedStatus = asset.status;
    String _selectedType = asset.assetType.toString();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Asset'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: ListBody(
                children: <Widget>[
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _serialNumController,
                    decoration:
                        const InputDecoration(labelText: 'Serial Number'),
                    // Add validator if needed
                  ),
                  DropdownButtonFormField<String>(
                    value: _selectedStatus,
                    items: [
                      'In Inventory',
                      'Checked Out',
                      'Available',
                      'Recycled'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      _selectedStatus = newValue!;
                    },
                    decoration: const InputDecoration(labelText: 'Status'),
                  ),
                  DropdownButtonFormField<String>(
                    value: _selectedType,
                    items: ['1', '2', '3', '4', '5']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      _selectedType = newValue!;
                    },
                    decoration: const InputDecoration(labelText: 'Type'),
                  ),
                  TextFormField(
                    controller: _externalAccessoriesController,
                    decoration: const InputDecoration(
                        labelText: 'External Accessories'),
                    // Add validator if needed
                  ),
                  TextFormField(
                    controller: _internalFeaturesController,
                    decoration:
                        const InputDecoration(labelText: 'Internal Features'),
                    // Add validator if needed
                  ),
                  TextFormField(
                    controller: _wirelessNICController,
                    decoration:
                        const InputDecoration(labelText: 'Wireless NIC'),
                    // Add validator if needed
                  ),
                  // Add other fields as necessary
                ],
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
              child: const Text('Save'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _updateAsset(
                    asset.id,
                    _descriptionController.text,
                    _selectedStatus,
                    _selectedType,
                    _serialNumController.text,
                    _externalAccessoriesController.text,
                    _internalFeaturesController.text,
                    _wirelessNICController.text,
                  );
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
