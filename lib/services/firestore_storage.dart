import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ocassetmanagement/models/user_group_model.dart';
import 'package:ocassetmanagement/models/user_model.dart';
import 'package:ocassetmanagement/models/vendor_model.dart';
import '/models/asset_instance.dart';
import '/models/asset_model.dart';

class FirestoreStorage {
  static const _users = 'Users';
  static const _assets = 'Asset';
  static const _vendors = 'Vendors';
  static const _userGroups = 'UserGroups';
  static const _miscellaneous = 'Miscellaneous';
  final db = FirebaseFirestore.instance;
  List<String> ug = [];

  static final FirestoreStorage _singleton = FirestoreStorage._internal();

  factory FirestoreStorage() {
    return _singleton;
  }

  FirestoreStorage._internal();

  Future<int> getValue() async {
    final doc = await db.collection('temp').doc('temp').get();
    return doc.get('num') ?? 0;
  }

  // All Firestore methods for 'Vendors'

  Future<List<Vendor>> getVendors() async {
    final snapshot = await db.collection(_vendors).get();

    return snapshot.docs.map((doc) => Vendor.fromFirestore(doc)).toList();
  }

  Future<void> updateVendor(String vendorId, Map<String, dynamic> data) async {
    await db.collection(_vendors).doc(vendorId).update(data);
  }

  Future<void> insertVendor(Vendor vendor) {
    return db.collection(_vendors).doc(vendor.vendorId).set({
      'vendorId': vendor.vendorId,
      'type': vendor.type,
      'name': vendor.name,
    });
  }

  // All Firestore methods for 'Asset' (Asset Instances)

  Future<AssetInstance> getAsset(int serialNum) async {
    AssetInstance asset = AssetInstance();

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

  Future<void> insertAsset(Asset asset) async {
    DocumentReference docRef = await db.collection(_assets).add(asset.toMap());

    String autoGeneratedId = docRef.id;

    return await db.collection(_assets).doc(autoGeneratedId).update({
      'assetId': autoGeneratedId,
    });
  }

  Future<List<Asset>> getAssets() async {
    final snapshot = await db.collection(_assets).get();
    return snapshot.docs.map((doc) => Asset.fromFirestore(doc)).toList();
  }

  Future<void> removeAssetInstance(Asset asset) async {
    db.collection(_assets).doc(asset.id).delete();
  }

  Future<void> updateAsset(String assetId, Map<String, dynamic> data) async {
    return await db.collection(_assets).doc(assetId).update(data);
  }

  // All Firestore Functions for 'Users'

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
        await db.collection(_users).get();

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
    return db.collection(_users).doc(user.userId).set({
      'userId': user.userId,
      'email': user.email,
      'name': user.name,
      'schoolId': user.schoolId,
      'userGroup': 'IT',
    });
  }

  Future<void> updateUser(User user) async {
    await db.collection(_users).doc(user.userId).update(user.toMap());
  }

  Future<List<User>> getUsers() async {
    final snapshot = await db.collection(_users).get();

    return snapshot.docs.map((doc) => User.fromFirestore(doc)).toList();
  }

  // All methods for 'UserGroups' in Firebase

  Future<List<UserGroup>> getUserGroups() async {
    final snapshot = await db.collection(_userGroups).get();

    return snapshot.docs.map((doc) => UserGroup.fromFirestore(doc)).toList();
  }

  Future<List<String>> getUserG() async {
    return ug;
  }

  Future<void> insertUserGroup(UserGroup userGroup) {
    ug.add(userGroup.name);
    return db.collection(_miscellaneous).doc('miscellaneous').set({
      'UserGroup': FieldValue.arrayUnion(ug),
    });
  }

  Future<void> updateUserGroup(String group) async {
    final newGroup = <String, dynamic>{
      'UserGroup': group,
    };
    await db.collection(_miscellaneous).doc('miscellaneous').update(newGroup);
  }

  Future<void> removeUserGroup(String group) async {
    List<String> removeName = [];
    removeName.add(group);
    return db.collection(_miscellaneous).doc('miscellaneous').set({
      'UserGroup': FieldValue.arrayRemove(removeName),
    });
  }

  // Miscellaneous Load

  Future<void> loadMisc() async {
    final event =
        await db.collection(_miscellaneous).doc('miscellaneous').get();

    ug = event
        .data()?['UserGroup']
        .map<String>((userGroup) => userGroup.toString())
        .toList();
  }
}
