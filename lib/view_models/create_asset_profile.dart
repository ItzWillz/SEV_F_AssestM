import 'package:flutter/material.dart';
import 'package:ocassetmanagement/services/firestore_storage.dart';

class CreateAssetNotifier extends ChangeNotifier {
  bool isProfileSelectionScreen = true;
  String? assetProfile;

  Future<void> completeProfileSelectionScren({String? assetName}) async {
    isProfileSelectionScreen = false;
    if (assetName == null) {
      assetProfile = null;
    } else {
      int value = await FirestoreStorage().getValue();
      assetProfile = '$value';
    }

    notifyListeners();
  }

  void completeAssetSelectScreen() {
    isProfileSelectionScreen = true;
    assetProfile = null;
    notifyListeners();
  }
}
