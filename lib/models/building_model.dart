import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ocassetmanagement/models/tableable.dart';

class Building implements Tableable {
  Building({String? name})
      : name = '',
        rooms = [];

  Building.fromFirestore(DocumentSnapshot snapshot)
      : name = snapshot['name'] ?? '',
        rooms = snapshot['rooms'] ?? [];

  late String name;
  late List<dynamic> rooms;

  @override
  List<String> header() {
    return ['Name', '# Rooms'];
  }

  @override
  List<Object?> asRow() {
    return [name, rooms.length];
  }

  
}
