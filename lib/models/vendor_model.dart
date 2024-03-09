import 'package:cloud_firestore/cloud_firestore.dart';
import 'tableable.dart';

class Vendor implements Tableable {
  Vendor({String? vendorId})
      : vendorId = vendorId ?? '',
        name = '',
        type = '';

  Vendor.fromFirestore(DocumentSnapshot snapshot)
      : name = snapshot['name'] ?? '',
        type = snapshot['type'] ?? 0,
        vendorId = snapshot['vendorId'] ?? '';

  late String name;
  late String type;
  late String vendorId;

  @override
  List<String> header() {
    return ['Name', 'Type', 'Actions'];
  }

  @override
  List<Object?> asRow() {
    return [
      name,
      type,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'vendorId': vendorId,
      'name': name,
      'type': type,
    };
  }

}
