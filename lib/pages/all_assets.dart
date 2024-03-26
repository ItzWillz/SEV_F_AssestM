import 'package:flutter/material.dart';
import 'package:ocassetmanagement/constants/constants.dart';
import 'package:ocassetmanagement/view_models/create_asset_profile.dart';
import 'package:ocassetmanagement/widgets/asset_list_data_table.dart';
import 'package:provider/provider.dart';
import '../models/asset_model.dart';
import '../services/firestore_storage.dart';

class AllAssetsPage extends StatefulWidget {
  const AllAssetsPage({super.key});

  @override
  State<StatefulWidget> createState() => _AllAssetsPageState();
}

class _AllAssetsPageState extends State<AllAssetsPage>
    with WidgetsBindingObserver {
  Future<List<Asset>> _assetListFuture = FirestoreStorage().getAssets();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _refreshAssets();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _refreshAssets();
    }
  }

  void _refreshAssets() {
    setState(() {
      _assetListFuture = FirestoreStorage().getAssets();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('All Assets'),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.refresh),
      //       onPressed: _refreshAssets,
      //     ),
      //   ],
      // ),
      body: FutureBuilder<List<Asset>>(
          future: _assetListFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No assets found.'));
            }
            return Material(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  children: [
                    const Center(
                        child: Text(
                      "All Assets",
                      style: TextStyle(fontSize: 30.0),
                      textAlign: TextAlign.center,
                    )),
                    Row(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 22.0, left: 20),
                          child: SizedBox(
                            width: 200,
                            child: TextField(
                              onChanged: (value) => setState(() {
                                // _filter(value);
                              }),
                              decoration: const InputDecoration(
                                labelText: 'Search',
                                suffixIcon: Icon(Icons.search),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 50,
                          child: IconButton(
                              onPressed: () {
                                final notifier =
                                    Provider.of<CreateAssetNotifier>(context,
                                        listen: false);
                                notifier.completeAllAssetScreen();
                              },
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              //label: const Text("", style: TextStyle(color: Colors.white)),
                              style: IconButton.styleFrom(
                                backgroundColor: addGreen,
                                //textStyle: const TextStyle(color: Colors.white),
                              )),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: AssetListDataTable(
                            data: snapshot.data!,
                            onViewMore: (asset) =>
                                _viewMoreInfo(context, asset),
                            onEdit: (asset) => _editAsset(context, asset),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
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
                  _buildDetailRow('Type:', asset.assetTypeId.toString()),
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
      String id,
      int type,
      int serialNum,
      int assetCategoryId,
      String description,
      String status,
      String externalAccessories,
      String internalFeatures,
      String wirelessNIC) {
    FirestoreStorage().updateAsset(id, {
      'assetProfileId': type,
      'assetCategoryId': assetCategoryId,
      'description': description,
      'serialNum': serialNum,
      'status': status,
      'wirelessNIC': wirelessNIC,
      'internalFeatures': internalFeatures,
      'externalAccessories': externalAccessories,
    }).then((_) {
      _refreshAssets();
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

  void _editAsset(BuildContext context, Asset asset) {
    // ignore: no_leading_underscores_for_local_identifiers
    final _formKey = GlobalKey<FormState>();
    final TextEditingController descriptionController =
        TextEditingController(text: asset.description);
    final TextEditingController serialNumController =
        TextEditingController(text: asset.serialNum.toString());
    final TextEditingController externalAccessoriesController =
        TextEditingController(text: asset.externalAccessories);
    final TextEditingController internalFeaturesController =
        TextEditingController(text: asset.internalFeatures);
    final TextEditingController wirelessNICController =
        TextEditingController(text: asset.wirelessNIC);
    final TextEditingController assetCategoryIdController =
        TextEditingController(text: asset.assetProfileId.toString());

    String selectedStatus = asset.status;
    String selectedType = asset.assetTypeId.toString();

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
                    controller: descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: serialNumController,
                    decoration:
                        const InputDecoration(labelText: 'Serial Number'),
                    // Add validator if needed
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedStatus,
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
                      selectedStatus = newValue!;
                    },
                    decoration: const InputDecoration(labelText: 'Status'),
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedType,
                    items: ['1', '2', '3', '4', '5']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      selectedType = newValue!;
                    },
                    decoration: const InputDecoration(labelText: 'Type'),
                  ),
                  TextFormField(
                    controller: externalAccessoriesController,
                    decoration: const InputDecoration(
                        labelText: 'External Accessories'),
                    // Add validator if needed
                  ),
                  TextFormField(
                    controller: internalFeaturesController,
                    decoration:
                        const InputDecoration(labelText: 'Internal Features'),
                    // Add validator if needed
                  ),
                  TextFormField(
                    controller: wirelessNICController,
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
              // ignore: sort_child_properties_last
              child: const Text('Save'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _updateAsset(
                    asset.id,
                    int.parse(selectedType),
                    int.parse(serialNumController.text),
                    int.parse(assetCategoryIdController.text),
                    descriptionController.text,
                    selectedStatus,
                    wirelessNICController.text,
                    externalAccessoriesController.text,
                    internalFeaturesController.text,
                  );
                  _refreshAssets();
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
