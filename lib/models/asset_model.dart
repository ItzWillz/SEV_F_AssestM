import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ocassetmanagement/models/tableable.dart';
import 'package:uuid/uuid.dart';

class Asset implements Tableable {
  Asset({
    String? id,
    required this.description,
    required this.serialNum,
    required this.status,
  })  : userGroup = "Admin",
        assetTypeId = 1,
        assetProfileId = 0,
        assetCategoryId = 0,
        externalAccessories = '',
        internalFeatures = '',
        wirelessNIC = '',
        id = id ?? const Uuid().v1();

  Asset.fromFirestore(DocumentSnapshot snapshot)
      : assetProfileId = snapshot['assetProfileId'] ?? 0,
        assetTypeId = snapshot['assetTypeId'] ?? 1,
        serialNum = snapshot['serialNum'] ?? 0,
        assetCategoryId = snapshot['assetCategoryId'] ?? 0,
        status = snapshot['status'] ?? 'In Inventory',
        description = snapshot['description'] ?? '',
        externalAccessories = snapshot['externalAccessories'] ?? '',
        internalFeatures = snapshot['internalFeatures'] ?? '',
        wirelessNIC = snapshot['wirelessNIC'] ?? '',
        id = snapshot['id'],
        userGroup = snapshot['userGroup'];

  late int assetTypeId;
  late int assetProfileId;
  late int assetCategoryId;
  late int serialNum;
  late String status;
  late String externalAccessories;
  late String internalFeatures;
  late String wirelessNIC;
  late String description;
  late String id;
  late String userGroup;

  @override
  List<String> header() {
    return ['Description', ' Serial Number', 'User Group', 'Status', 'Action'];
  }

  @override
  List<Object?> asRow() {
    return [description, serialNum, userGroup, status];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'serialNum': serialNum,
      'status': status,
      'userGroup': userGroup,
      'assetTypeId': assetTypeId,
      'assetProfileId': assetProfileId,
      'assetCategoryId': assetCategoryId,
      'externalAccessories': externalAccessories,
      'internalFeatures': internalFeatures,
      'wirelessNIC': wirelessNIC,
      'id': id
    };
  }
}
