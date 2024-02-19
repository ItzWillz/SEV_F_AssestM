import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ocassetmanagement/models/user_model.dart' as um;

class LoggedUserNotifier extends ChangeNotifier {
  // bool isProfileSelectionScreen = true; Change to unshow login screen rather than navigate?
  // String? userGroup;
  // String? userId;
  // int? schoolId;
  // String? name;
  um.User? user;

  bool get isLoggedIn => user != null;
//Flip to Landing Page & Back

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
    // TODO get info from Firestore
    this.user = um.User(
      email: user.email ?? 'No email',
      name: user.displayName ?? 'No display name',
      schoolId: 23409,
      userGroup: 'Admin',
    );


    // this.user = um.User(id: user.uid );
    // isProfileSelectionScreen = false;
    // if (field arg here) {
    //   userId = null;
    //   userGroup = null;
    //   name = null;
    // } else {
    // final user = await FirestoreStorage().getValue(); // Change this to grab all user data
    // userGroup = userModel.userGroup;
    // userId = userModel.userId;
    // name = userModel.name;
    // }

    notifyListeners();
  }

  void loggedUserOut() {
    user = null;
    notifyListeners();
  }
}
