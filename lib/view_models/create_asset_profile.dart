import 'package:flutter/material.dart';
import 'package:ocassetmanagement/services/firestore_storage.dart';

class CreateAssetNotifier extends ChangeNotifier {
  bool isAllAssets = true;
  bool isProfileSelectionScreen = false;
  bool isNewAsset = false;
  String? assetProfile;

  Future<void> completeAllAssetScreen() async{
    isProfileSelectionScreen = true;
    isAllAssets = false;
    notifyListeners();
  }

  Future<void> completeProfileSelectionScren({String? assetName}) async {
    isNewAsset = true;
    isProfileSelectionScreen = false;
    isAllAssets = false;
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
    isNewAsset = false;
    assetProfile = null;
    notifyListeners();
  }

  void completeProfileScreen() {
    isProfileSelectionScreen = false;
    isAllAssets = true;
    notifyListeners();
  }
}
