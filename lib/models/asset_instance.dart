import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class AssetInstance {
  AssetInstance({String? id})   // DocumentSnapshot snapshot(?)
      : assetTypeId = 0,
        assetProfileId = 0,
        serialNum = 0,
        status = '',
        description = '',
        externalAccessories = '',
        internalFeatures = '',
        wirelessNIC = '',
        id = id ?? _uuid.v1();

        AssetInstance.fromFirestore(DocumentSnapshot snapshot)
        : assetProfileId = snapshot['assetProfileId'] ?? 0,
        assetTypeId = snapshot['assetTypeId'] ?? 0,
        serialNum = snapshot['serialNum'] ?? 0,
        status = snapshot['status'] ?? '',
        description = snapshot['description'] ?? '',
        externalAccessories = snapshot['externalAccessories'] ?? '',
        internalFeatures = snapshot['internalFeatures'] ?? '',
        wirelessNIC = snapshot['wirelessNIC'] ?? '',
        id = snapshot.id;


      
  late int assetTypeId;
  late int assetProfileId;
  late int serialNum;
  late String status;
  late String externalAccessories;
  late String internalFeatures;
  late String wirelessNIC;
  static const _uuid = Uuid();
  late String description;
  late final String id;
}