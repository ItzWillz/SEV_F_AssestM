import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: unused_import
import '../view_models/cells/dropdown_cell.dart';
import 'tableable.dart';

class Building implements Tableable {
  Building({
    required this.name,
    required this.roomNum,
    required this.assetTotal,
  }): id = '0';

  Building.fromFirestore(DocumentSnapshot snapshot)
      :
        roomNum = snapshot['roomNum'] ?? '',
        assetTotal = snapshot['assetTotal'] ?? '',
        name = snapshot['name'] ?? '',
        id = snapshot.id;

  String name;
  int roomNum;
  int assetTotal;
  final String id;


  @override
  List<String> header() {
    return [ 'Name', 'Number of Rooms', "Total Asset's assigned"];

  }

  @override
  List<Object?> asRow() {
    return [
      name,
      roomNum,
      assetTotal,
    ];
  }

}