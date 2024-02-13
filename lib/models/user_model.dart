import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class User {
  User({String? id})   // DocumentSnapshot snapshot(?)
      : userId = 0,
        name = '',
        email = '',
        userGroup = '',
        id = id ?? _uuid.v1();

        AssetProfile.fromFirestore(DocumentSnapshot snapshot)
        : email = snapshot['email'] ?? '',
        userGroup = snapshot['userGroup'] ?? '',
        name = snapshot['name'] ?? ''
        userId = snapshot['userId'] ?? 0,
        id = snapshot.id;


  late String userGroup;
  late String name;
  static const _uuid = Uuid();
  late String email;
  late final String id;
  late int userId;
}