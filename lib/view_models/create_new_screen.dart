import 'package:flutter/material.dart';
import 'package:ocassetmanagement/models/building_model.dart';

import '../models/room_model.dart';

class CreateNewScreenNotifier extends ChangeNotifier {
  bool isMaintenancescreen = true;
  bool isNewVendorPage = false;
  bool isAllVendors = false;

  bool isAllBuildings = false;
  bool isNewBuilding = false;
  bool isViewBuilding = false;
  bool isRoomPage = false;
  Building? selectedBuilding;
  Room? selectedRoom;

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

  Future<void> allBuildingScreen() async {
    isAllBuildings = true;
    isMaintenancescreen = false;
    notifyListeners();
  }

  Future<void> newBuilding() async {
    isAllBuildings = false;
    isNewBuilding = true;
    notifyListeners();

  }

  Future<void> buildingScreen({required Building? building}) async{
    //print(building?.name);
    isAllBuildings = false;
    isViewBuilding = true;
     if (building == null) {
      selectedBuilding = null;
    } else {
      //int value = await FirestoreStorage().getValue();
      //assetProfile = '$value';
      selectedBuilding = building;
    }
    notifyListeners();

  }

  Future<void> roomScreen({required Room room}) async{
    isViewBuilding = false;
    isRoomPage = true;
    //  if (room == null) {
    //   selectedRoom = null;
    // } else {
      //int value = await FirestoreStorage().getValue();
      //assetProfile = '$value';
      selectedRoom = room;
    //}
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

  void completeViewRoomPage(){
    isRoomPage = false;
    isViewBuilding = true;
    notifyListeners();
  }

}