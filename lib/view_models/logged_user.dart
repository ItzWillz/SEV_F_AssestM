import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ocassetmanagement/models/user_model.dart' as um;
import 'package:ocassetmanagement/services/firestore_storage.dart';

class LoggedUserNotifier extends ChangeNotifier {
  // bool isProfileSelectionScreen = true; Change to unshow login screen rather than navigate?
  String? _userGroup;
  // ignore: unused_field
  String? _userId;
  int? _schoolId;
  String? _name;
  String? _email;
  um.User? user;
  FirestoreStorage firestoreStorage = FirestoreStorage();

  // Getters
  bool get isLoggedIn => user != null;
  //Map<String, String> get userData => {'email': user.email, 'name': user.name};
  String? get userGroup => _userGroup;
  String? get name => _name;
  String? get email => _email;
  int? get schoolId => _schoolId;

  LoggedUserNotifier() {
    FirebaseAuth.instance.authStateChanges().listen((User? event) {
      if (event == null) {
        loggedUserOut();
        return;
      }
      // completeLoginFunctionality(event);
    });
  }

  Future<void> completeLoginFunctionality(User user) async {
    this.user = um.User(userId: user.uid);

    final userData = await firestoreStorage.getUser(this.user!.userId);
    _userId = userData.userId;
    _email = userData.email;
    _userGroup = userData.userGroup;
    _name = userData.name;
    _schoolId = userData.schoolId;

    //print("User Data: ${userData.userId} and ${userData.name}");
    notifyListeners();
  }

  Future<void> completeSignUpFunctionality(User user,
      [int schoolId = 0]) async {
    this.user = um.User(userId: user.uid);
    this.user!.email = user.email!;
    this.user!.name = user.displayName!;
    this.user!.schoolId = schoolId;
    this.user!.userGroup = "IT";

    firestoreStorage.insertUser(this.user!);
    //print("Inserted new user: ${this.user}");

    final userData = await firestoreStorage.getUser(this.user!.userId);
    _userId = userData.userId;
    _email = userData.email;
    _userGroup = userData.userGroup;
    _name = userData.name;
    _schoolId = userData.schoolId;

    notifyListeners();
  }

  void loggedUserOut() {
    user = null;
    notifyListeners();
  }
}
