import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ocassetmanagement/models/tableable.dart';

class Room implements Tableable {
  Room({String? name, String? buildingName})
      : name = name ?? '',
        buildingName = buildingName ?? '';

  Room.fromFirestore(DocumentSnapshot snapshot)
      : name = snapshot['name'] ?? '',
        buildingName = snapshot['buildingName'] ?? '';

  late String name;
  late String buildingName;

  @override
  List<String> header() {
    return ['Name', 'Building Name'];
  }

  @override
  List<Object?> asRow() {
    return [name, buildingName];
  }

  
}
