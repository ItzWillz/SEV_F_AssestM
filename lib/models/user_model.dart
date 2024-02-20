import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:uuid/uuid.dart';

class User {
  User({String? userId, int? schoolId}) // DocumentSnapshot snapshot(?)
      : userId = userId ?? '',
        name = '',
        email = '',
        userGroup = '',
        schoolId = schoolId ?? 0;
  //id = id ?? _uuid.v1();

  User.fromFirestore(DocumentSnapshot snapshot)
      : email = snapshot['email'] ?? '',
        userGroup = snapshot['userGroup'] ?? '',
        name = snapshot['name'] ?? '',
        userId = snapshot['userId'] ?? 0,
        schoolId = snapshot['schoolId'] ?? 0;
  //id = snapshot.id;

  late String userGroup;
  late String name;
  //static const _uuid = Uuid();
  late String email;
  //late final String id;
  late String userId;
  late int schoolId;
}
