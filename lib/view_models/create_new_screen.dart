import 'package:flutter/material.dart';

class CreateNewScreenNotifier extends ChangeNotifier {
  bool isMaintenancescreen = true;
  bool isNewVendorPage = false;
  bool isAllVendors = false;
  bool isAllUserGroupsPage = false;
  bool isNewUserGroup = false;

  Future<void> allVendorScreen() async {
    isAllVendors = true;
    isMaintenancescreen = false;
    notifyListeners();
  }

  Future<void> newVendor() async {
    isNewVendorPage = true;
    isAllVendors = false;
    notifyListeners();
  }

  void completeNewVScreen() {
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

  void completeAllUGPage(){
    isMaintenancescreen = true;
    isAllUserGroupsPage = false;
    isNewUserGroup = false;
    notifyListeners();
  }

  Future<void> newUserGroup() async {
    isNewUserGroup = true;
    isAllUserGroupsPage = false;
    notifyListeners();
  }

  Future<void> allUGScreen() async {
    isAllUserGroupsPage = true;
    isMaintenancescreen = false;
    notifyListeners();
  }

  void completeNewUGScreen() {
    isMaintenancescreen = false;
    isAllUserGroupsPage = true;
    isNewUserGroup = false;
    notifyListeners();
  }
}