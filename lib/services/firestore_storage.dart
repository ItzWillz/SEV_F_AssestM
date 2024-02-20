import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/asset_instance.dart';
// import 'package:todo_william_mcdonald/controllers/auth_controller.dart';

class FirestoreStorage {
  // static const _tasks = 'tasks';
  // static const _description = 'description';
  // static const _dueDate = 'due_date';
  // static const _users = 'users';
  final db = FirebaseFirestore.instance;
  // final userId = AuthController().getUserId();

  Future<int> getValue() async {
    final doc = await db.collection('temp').doc('temp').get();
    return doc.get('num') ?? 0;
  }

  // @override
  // Future<List<Task>> getTasks() async {
  //     List<Task> tasklist = [];

  //     if(userId != null) {
  //       await db.collection(_users).doc(userId).collection(_tasks).get().then((
  //           event) {
  //         for (var doc in event.docs) {
  //           String desc = doc.data()[_description];
  //           DateTime? dd = toDateTime(doc.data()[_dueDate]);
  //           Task newtask = Task(description: '$desc', id: doc.id);
  //           newtask.duedate = dd;
  //           tasklist.add(newtask);
  //         }
  //       });
  //     }

  //     return tasklist;
  // }

  Future<AssetInstance> getAsset(int serialNum) async {
    AssetInstance asset = AssetInstance();

      QuerySnapshot<Map<String, dynamic>> event = await db
          .collection('Asset')
          .where(serialNum)
          .get();

      for (var doc in event.docs) {
        final data = doc.data();
       
        asset.description = data['description'];
        asset.serialNum = doc.data()['serialNum'];
        asset.wirelessNIC = doc.data()['wirelessNIC'];
      }
    

    return asset;
  }

  Future<void> insertAssetInstance(AssetInstance asset) {
    return db.collection('Asset').doc().set({
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

  // @override
  // Future<void> removeAssetInstance(Task task) async {

  //   print(task.id);
  //   db.collection(_users).doc(userId).collection(_tasks).doc(task.id).delete().then(
  //         (doc) => print("Document deleted"),
  //     onError: (e) => print("Error updating document $e"),
  //   );

  // }
}
