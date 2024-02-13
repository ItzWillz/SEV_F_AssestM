import 'package:flutter/material.dart';
import 'package:ocassetmanagement/services/firestore_storage.dart';
import 'package:ocassetmanagement/models/user_model.dart';

class LoggedUserNotifier extends ChangeNotifier {
  bool isProfileSelectionScreen = true;
  String? userGroup;
  int userId;
  String? name;

  Future<void> completeProfileSelectionScren({String? assetName}) async {
    isProfileSelectionScreen = false;
    if (assetName == null) {
      assetProfile = null;
    } else {
      User user = await FirestoreStorage().getValue(); // Change this to grab all user data
      assetProfile = '$value';
    }

    notifyListeners();
  }

  void completeAssetSelectScreen() {
    isProfileSelectionScreen = false;
    assetProfile = null;
    notifyListeners();
  }
}
