import 'package:flutter/material.dart';

class CreateNewScreenNotifier extends ChangeNotifier {
  bool isMaintenancescreen = true;
  bool isNewVendorPage = false;
  bool isAllVendors = false;

  Future<void> newScreen() async {
    isAllVendors = true;
    isMaintenancescreen = false;
    notifyListeners();
  }

  Future<void> newVendor() async {
    isNewVendorPage = true;
    isAllVendors = false;
    notifyListeners();
  }

  void completeNewScreen() {
    isMaintenancescreen = false;
    isAllVendors = true;
    isNewVendorPage = false;
    notifyListeners();
  }

  void completeAllVendorPage(){
    isMaintenancescreen = true;
    isAllVendors = false;
    isNewVendorPage = false;
    notifyListeners();
  }
}