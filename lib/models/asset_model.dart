import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ocassetmanagement/models/tableable.dart';
import 'package:uuid/uuid.dart';

class Asset implements Tableable {
  Asset({
    String? id,
    required this.description,
    required this.assetType,
    required this.serialNum,
    required this.status,
  })  : assetProfileId = 0,
        externalAccessories = '',
        internalFeatures = '',
        wirelessNIC = '',
        id = id ?? const Uuid().v1();

  Asset.fromFirestore(DocumentSnapshot snapshot)
      : assetProfileId = snapshot['assetProfileId'] ?? 0,
        assetType = snapshot['assetCategoryId'] ?? 0,
        serialNum = snapshot['serialNum'] ?? 0,
        status = snapshot['status'] ?? '',
        description = snapshot['description'] ?? '',
        externalAccessories = snapshot['externalAccessories'] ?? '',
        internalFeatures = snapshot['internalFeatures'] ?? '',
        wirelessNIC = snapshot['wirelessNIC'] ?? '',
        id = snapshot['id'];

  final int assetType;
  final int assetProfileId;
  final int serialNum;
  final String status;
  final String externalAccessories;
  final String internalFeatures;
  final String wirelessNIC;
  final String description;
  final String id;

  @override
  List<String> header() {
    return ['Description', 'Type', 'Serial Number', 'Status', 'Action'];
  }

  @override
  List<Object?> asRow() {
    return [description, assetType, serialNum, status, null];
  }
}
