import 'package:cloud_firestore/cloud_firestore.dart';
import '../view_models/cells/dropdown_cell.dart';
import 'tableable.dart';

class User implements Tableable {
  User({
    required this.name,
    required this.email,
    required this.schoolId,
    required this.userGroup,
  }): id = '0';

  User.fromFirestore(DocumentSnapshot snapshot)
      : email = snapshot['email'] ?? '',
        userGroup = snapshot['userGroup'] ?? '',
        name = snapshot['name'] ?? '',
        schoolId = snapshot['userId'] ?? 0,
        id = snapshot.id;

  String userGroup;
  String name;
  String email;
  final String id;
  int schoolId;

  static final userGroupOptions = <String>[
    'Admin',
    'IT',
    'Support Central',
    'Maintenance',
  ]; // store and pull this from Firestore.

  @override
  List<String> header() {
    return ['School ID', 'Name', 'Email', 'User Group'];
  }

  @override
  List<Object?> asRow() {
    return [
      id,
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
    }
  }
}
