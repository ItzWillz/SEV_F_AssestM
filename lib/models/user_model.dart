import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ocassetmanagement/services/firestore_storage.dart';
import '../view_models/cells/dropdown_cell.dart';
import 'tableable.dart';

class User implements Tableable {
  User({String? userId, int? schoolId})
      : userId = userId ?? '',
        name = '',
        email = '',
        userGroup = '',
        schoolId = schoolId ?? 0;

  User.fromFirestore(DocumentSnapshot snapshot)
      : email = snapshot['email'] ?? '',
        userGroup = snapshot['userGroup'] ?? '',
        name = snapshot['name'] ?? '',
        schoolId = snapshot['schoolId'] ?? 0,
        userId = snapshot['userId'] ?? '';

  String userGroup;
  String name;
  String email;
  String userId;
  int schoolId;

  // static final userGroupOptions = <String>[
  //   'Admin',
  //   'IT',
  //   'Support Central',
  //   'Maintenance',
  // ]; // store and pull this from Firestore.

  static final List<String> userGroupOptions = [];

  static init() async {
    final userGroups = await FirestoreStorage().getUserGroups();
    final names = userGroups.map<String>((e) => e.name);
    userGroupOptions.addAll(names);
  }

  // Future<List<String>> getNames( ) async {
  //   final userGroups = await userGroupOptions;
  //   List<String> names = userGroups.map<String>((UserGroup e) => e.name).toList();
  // }

  @override
  List<String> header() {
    return ['School ID', 'Name', 'Email', 'User Group'];
  }

  @override
  List<Object?> asRow() {
    return [
      schoolId,
      name,
      email,
      DropdownCell(
        value: userGroup,
        items: userGroupOptions,
        updateValue: updateUserGroup,
      )
    ];
  }

  void updateUserGroup(String? value) {
    if (value != null) {
      userGroup = value;
      FirestoreStorage().updateUser(this);
    }
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'name': name,
      'email': email,
      'userGroup': userGroup,
      'schoolId': schoolId,
    };
  }
}
