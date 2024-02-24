import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class AssetProfile {
  AssetProfile({String? id}) // DocumentSnapshot snapshot(?)
      : assetTypeId = 0,
        name = '',
        model = '',
        modelNum = '',
        domain = '',
        accessories = '',
        internalFeatures = '',
        manufacturer = '',
        memory = '',
        hasLease = false,
        hasWarranty = false,
        processor = '',
        hardDrive = '',
        keyRoom = 0,
        keyNum = 0,
        description = '',
        userGroupId = 0,
        id = id ?? _uuid.v1();

  AssetProfile.fromFirestore(DocumentSnapshot snapshot)
      : assetTypeId = snapshot['assetTypeId'] ?? 0,
        name = snapshot['name'] ?? '',
        model = snapshot['model'] ?? '',
        modelNum = snapshot['modelNum'] ?? '',
        domain = snapshot['domain'] ?? '',
        description = snapshot['description'] ?? '',
        accessories = snapshot['accessories'] ?? '',
        internalFeatures = snapshot['internalFeatures'] ?? '',
        manufacturer = snapshot['manufacturer'] ?? '',
        hasLease = snapshot['hasLease'] ?? false,
        hasWarranty = snapshot['hasWarranty'] ?? false,
        memory = snapshot['memory'] ?? '',
        processor = snapshot['processor'] ?? '',
        hardDrive = snapshot['hardDrive'] ?? '',
        keyRoom = snapshot['keyRoom'] ?? 0,
        keyNum = snapshot['keyNum'] ?? 0,
        userGroupId = snapshot['userGroupId'] ?? 0,
        id = snapshot.id;

  AssetProfile.fromCSV(List<dynamic> row)
      : id = row[0], //"@id "
        manufacturer = row[1], // "O11 Eqp Manufacturer "
        model = row[2], //"O11 Eqp Model "
        modelNum = row[3], // "O11 Eqp Model Num "
        description = row[4], // "O11 Eqp Description "
        memory = row[5], // "O11 Eqp Memory "
        hardDrive = row[6], // "O11 Eqp Harddrive "
        processor = row[7], // "O11 Eqp Processor "
        internalFeatures = row[8], // "O11 Eqp Features "
        accessories = row[9], // "O11 Eqp Accessories "
        // "O11 Eqp Toner Type ",
        // "O11 Eqp Purchase Date "
        hasWarranty = row[12].toString().isNotEmpty, // "O11 Eqp Warrenty Type "
        // "O11 Eqp Warrenty Length "
        // "O11 Eqp Warrenty End Date "
        hasLease = row[15].toString().isNotEmpty, // "O11 Eqp Lease Term "
        // "O11 Eqp Term Length "
        // "O11 Eqp Lease End Date "
        // "O11 Eqp Service Type "
        // "O11 Eqp Service Vendor "
        // "O11 Eqp Service Start Date "
        // "O11 Eqp Service Length "
        // "O11 Eqp Type "

        // Unknown
        assetTypeId = 0,
        name = '',
        domain = '',
        keyRoom = 0,
        keyNum = 0,
        userGroupId = 0;

  Map<String, dynamic> toMap() {
    return {
      'assetTypeId': assetTypeId,
      'name': name,
      'model': model,
      'modelNum': modelNum,
      'domain': domain,
      'description': description,
      'accessories': accessories,
      'internalFeatures': internalFeatures,
      'manufacturer': manufacturer,
      'hasLease': hasLease,
      'hasWarranty': hasWarranty,
      'memory': memory,
      'processor': processor,
      'hardDrive': hardDrive,
      'keyRoom': keyRoom,
      'keyNum': keyNum,
      'userGroupId': userGroupId,
      // excludes id
    };
  }

  static const _uuid = Uuid();
  String model;
  int assetTypeId;
  int userGroupId;
  String name;
  String description;
  final String id;
  String domain;
  String manufacturer;
  bool hasWarranty;
  bool hasLease;
  String memory;
  String processor;
  String modelNum;
  String hardDrive;
  int keyRoom;
  int keyNum;
  String accessories;
  String internalFeatures;
}
