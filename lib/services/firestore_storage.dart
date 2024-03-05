//import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ocassetmanagement/models/building_model.dart';
import 'package:ocassetmanagement/models/person_model.dart';
import 'package:ocassetmanagement/models/room_model.dart';
import 'package:ocassetmanagement/models/user_model.dart';
import '/models/asset_instance.dart';
import '/models/asset_model.dart';
// import 'package:todo_william_mcdonald/controllers/auth_controller.dart';

class FirestoreStorage {
  // static const _description = 'description';
  static const _users = 'Users';
  static const _assets = 'Asset';
  static const _people = 'People';
  static const _buildings = 'Buildings';
  static const _rooms = 'Rooms';

  final db = FirebaseFirestore.instance;
  //final _userId = AuthController().getUserId();

  Future<int> getValue() async {
    final doc = await db.collection('temp').doc('temp').get();
    return doc.get('num') ?? 0;
  }

  Future<List<User>> getUsers() async {
    final snapshot = await db.collection(_users).get();

    return snapshot.docs.map((doc) => User.fromFirestore(doc)).toList();
  }

  Future<AssetInstance> getAsset(int serialNum) async {
    AssetInstance asset = AssetInstance();
    // db.collection('Asset').where('serialNum', isEqualTo: serialNum).limit(1).get();

    QuerySnapshot<Map<String, dynamic>> event =
        await db.collection(_assets).where(serialNum).get();

    for (var doc in event.docs) {
      final data = doc.data();

      asset.description = data['description'];
      asset.serialNum = doc.data()['serialNum'];
      asset.wirelessNIC = doc.data()['wirelessNIC'];
    }

    return asset;
  }

  Future<void> updateUser(User user) async {
    await db.collection(_users).doc(user.userId).update(user.toMap());
  }

  Future<void> insertAssetInstance(AssetInstance asset) {
    return db.collection(_assets).doc().set({
      'id': "33",
      'assetProfileId': 2,
      'assetCategoryId': 5,
      'description': asset.description,
      'serialNum': asset.serialNum,
      'status': 'In Inventory',
      'wirelessNIC': asset.wirelessNIC,
      'internalFeatures': 'Mhm',
      'externalAccessories': 'Wireless G502'
    });
  }

// Get all asset instances
  Future<List<Asset>> getAssets() async {
    final snapshot = await db.collection(_assets).get();
    return snapshot.docs.map((doc) => Asset.fromFirestore(doc)).toList();
  }

// Get all people
  Future<List<Person>> getPeople() async {
    final snapshot = await db.collection(_people).get();
    return snapshot.docs.map((doc) => Person.fromFirestore(doc)).toList();
  }

// Get all buildings
  Future<List<Building>> getBuildings() async {
    final snapshot = await db.collection(_buildings).get();
    return snapshot.docs.map((doc) => Building.fromFirestore(doc)).toList();
  }

// Get all rooms
  Future<List<Room>> getRooms() async {
    final snapshot = await db.collection(_rooms).get();
    return snapshot.docs.map((doc) => Room.fromFirestore(doc)).toList();
  }

// Get all the names of rooms for a certain building.
  Future<List<dynamic>> getRoomsForBuilding(String buildingName) async {
    List<dynamic> rooms = [];

    QuerySnapshot<Map<String, dynamic>> event =
        await db.collection('Buildings').get();

    for (var doc in event.docs) {
      if (doc.data()['name'] == buildingName) {
        final data = doc.data();
        rooms = data['rooms'];
      }
    }

    return rooms;
  }

  Future<List<DropdownMenuItem>> getPeopleAsDropdownMenuItems() async {
    var people = await getPeople();
    List<DropdownMenuItem> menuItems = [];
    menuItems.add(DropdownMenuItem(value: '', child: Text('')));
    for (Person person in people) {
      var newItem = DropdownMenuItem(
          value: '${person.name} ${person.schoolId}',
          child: Text('${person.name} ${person.schoolId}'));

      menuItems.add(newItem);
    }
    return menuItems;
  }

  Future<List<DropdownMenuItem>> getBuildingsAsDropdownMenuItems() async {
    var buildings = await getBuildings();
    List<DropdownMenuItem> menuItems = [];
    menuItems.add(DropdownMenuItem(value: '', child: Text('')));
    for (Building building in buildings) {
      var newItem =
          DropdownMenuItem(value: building.name, child: Text(building.name));

      menuItems.add(newItem);
    }
    return menuItems;
  }

  Future<List<DropdownMenuItem>> getRoomsForBuildingAsDropdownMenuItems(
      String buildingName) async {
    var rooms = await getRoomsForBuilding(buildingName);
    List<DropdownMenuItem> menuItems = [];
    menuItems.add(DropdownMenuItem(value: '', child: Text('')));
    for (String room in rooms) {
      var newItem = DropdownMenuItem(value: room, child: Text(room));

      menuItems.add(newItem);
    }
    return menuItems;
  }

  // @override
  // Future<void> removeAssetInstance(Task task) async {

  //   print(task.id);
  //   db.collection(_users).doc(userId).collection(_tasks).doc(task.id).delete().then(
  //         (doc) => print("Document deleted"),
  //     onError: (e) => print("Error updating document $e"),
  //   );

  // }

  Future<bool> userExists(String userId) async {
    bool userExists = false;
    final users = await db
        .collection("Users")
        .where("userId", isEqualTo: userId)
        .count()
        .get();
    if (users.count! > 0) {
      userExists = true;
    }

    return userExists;
  }

  Future<bool> userExistsWithEmail(String email) async {
    bool userExists = false;
    final users = await db
        .collection("Users")
        .where("email", isEqualTo: email)
        .count()
        .get();
    if (users.count! > 0) {
      userExists = true;
    }

    return userExists;
  }

  Future<User> getUser(String userId) async {
    User user = User();

    QuerySnapshot<Map<String, dynamic>> event =
        await db.collection('Users').get();

    for (var doc in event.docs) {
      if (doc.data()['userId'] == userId) {
        final data = doc.data();

        user.email = data['email'];
        user.name = doc.data()['name'];
        user.schoolId = doc.data()['schoolId'];
        user.userGroup = doc.data()['userGroup'];
        user.userId = doc.data()['userId'];
      }
    }

    return user;
  }

  Future<void> insertUser(User user) {
    return db.collection('Users').doc(user.userId).set({
      'userId': user.userId,
      'email': user.email,
      'name': user.name,
      'schoolId': user.schoolId,
      'userGroup': 'IT',
    });
  }

  Future<void> insertPerson(Person person) {
    return db.collection('People').doc().set({
      'email': person.email,
      'name': person.name,
      'schoolId': person.schoolId,
    });
  }

  Future<void> assignAsset(String assetSerial, int? personSchoolID,
      String buildingName, String roomName, String returnDate) async {
    // Add new document to Assignments collection
    return db.collection('Assignments').doc().set({
      'assetSerialNumber': assetSerial,
      'personSchoolID': personSchoolID,
      'building': buildingName,
      'room': roomName,
      'assignedDate': DateTime.now().toString().split(" ")[0],
      'returnDate': returnDate,
    });
  }
}
