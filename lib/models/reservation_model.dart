import 'package:cloud_firestore/cloud_firestore.dart';
import '../view_models/cells/dropdown_cell.dart';
import 'tableable.dart';

class Reservations implements Tableable {
  Reservations({
    required this.schoolId,
    required this.name,
    required this.email,
    required this.assetType,
  }): id = '0';

  Reservations.fromFirestore(DocumentSnapshot snapshot)
      : email = snapshot['email'] ?? '',
        assetType = snapshot['assetType'] ?? '',
        name = snapshot['name'] ?? '',
        schoolId = snapshot['userId'] ?? 0,
        id = snapshot.id;

  String assetType;
  String name;
  String email;
  final String id;
  int schoolId;

  static final assetTypeOptions = <String>[
    'Laptop',
    'Projector',
    'Calculator',
  ]; // TODO store and pull this from Firestore.

  @override
  List<String> header() {
    return ['School ID', 'Name', 'Email', 'Request for'];
  }

  @override
  List<Object?> asRow() {
    return [
      schoolId,
      name,
      email,
      DropdownCell(
        value: assetType,
        items: assetTypeOptions,
        updateValue: updateAssetType,
      )
    ];
  }

  void updateAssetType(String? value) {
    if (value != null) {
      assetType = value;
    }
  }
}
