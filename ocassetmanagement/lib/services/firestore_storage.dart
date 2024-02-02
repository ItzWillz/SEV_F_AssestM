import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<void> insertTask(int num) {
    return db.collection('temp').doc('temp').set({'num': num});
  }

  // @override
  // Future<void> removeTask(Task task) async {

  //   print(task.id);
  //   db.collection(_users).doc(userId).collection(_tasks).doc(task.id).delete().then(
  //         (doc) => print("Document deleted"),
  //     onError: (e) => print("Error updating document $e"),
  //   );

  // }
}
