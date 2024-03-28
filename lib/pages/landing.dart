import 'package:flutter/material.dart';
import 'package:ocassetmanagement/models/building_model.dart';
import 'package:ocassetmanagement/pages/add_vendor_page.dart';
import 'package:ocassetmanagement/pages/all_assets.dart';
import 'package:ocassetmanagement/pages/all_buildings_page.dart';
import 'package:ocassetmanagement/pages/all_users_page.dart';
import 'package:ocassetmanagement/pages/all_vendors_page.dart';
//import 'package:ocassetmanagement/pages/all_vendors_page.dart';
import 'package:ocassetmanagement/pages/asset_page.dart';
import 'package:ocassetmanagement/pages/asset_profile_selection_page.dart';
import 'package:ocassetmanagement/pages/new_check_out_page.dart';
import 'package:ocassetmanagement/pages/reports_page.dart';
import 'package:ocassetmanagement/pages/view_building_page.dart';
import 'package:ocassetmanagement/view_models/create_new_screen.dart';
import 'package:provider/provider.dart';
import 'package:ocassetmanagement/view_models/create_asset_profile.dart';
import 'package:ocassetmanagement/view_models/logged_user.dart';
import '../models/room_model.dart';
import '../view_models/create_check_out.dart';
import 'check_in_and_out_page.dart';
//import 'reservation_page.dart';

import 'home_page.dart';
import '../sidebar.dart';
import 'maintenance _page.dart';
import 'roomPage.dart';
// import 'package:ocassetmanagement/sidebar.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  int _selectedIndex = 0;
  bool _showNavigationBar = true;
  bool readOnly = true;
  String? _attachedprofile;
  Building? _attachedbuilding;
  Room? _attachedroom;
  Object? _attachedasset;
  // ignore: unused_field
  bool _isOnAssetProfilePage = false;
  // ignore: unused_field
  bool _isOnCheckOutPage = false;
  bool _isOnMaintenancePage = false;



  @override
  Widget build(BuildContext context) {
     

    var name = context.watch<LoggedUserNotifier>().name;
    var userGroup = context.watch<LoggedUserNotifier>().userGroup;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(199, 108, 13, 13),
        title: Text(
          'OC Asset Management | Welcome $name',
          style: const TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              _showNavigationBar = !_showNavigationBar;
            });
          },
        ),
        actions: [       
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: IconButton(icon: const Icon(Icons.person), onPressed: () {  },
              style: IconButton.styleFrom(
              backgroundColor: Colors.white),
                                  //textStyle: const TextStyle(color: Colors.white),
                                )
           ),
],
      ),
      // body: Placeholder(),
      body: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (_showNavigationBar)
            SideBar(
              userGroup: userGroup,
              selectedIndex: _selectedIndex,
              onDestinationSelected: onDestinationSelected,
            ),
          Expanded(child: _mainContent()),
        ],
      ),
    );
  }

  Widget _mainContent() {
    if (_selectedIndex == 1) {
      final notifier = Provider.of<CreateAssetNotifier>(context);

      if(notifier.isAllAssets){
        return const AllAssetsPage();
      }
      else if(notifier.isProfileSelectionScreen){
        return AssetProfileSelectionPage(callBack: _navigateToAddAndEditAssetPage);
      }
      else if (notifier.isNewAsset){
        return AssetPage(profile: _attachedprofile,);
      }
      // return notifier.isProfileSelectionScreen
      //     ? AssetProfileSelectionPage(callBack: _navigateToAddAndEditAssetPage)
      //     : AssetPage(profile: _attachedprofile);
    } else if (_selectedIndex == 2) {
      final notifierTwo = Provider.of<CreateCheckOutNotifier>(context);

      return notifierTwo.isCheckOutScreen
           ? CheckInandOutPage(callBack: _navigateToAddAndEditCheckOutPage)
           : NewCheckOutPage(asset: _attachedasset,);

      //return const CheckInandOutPage();
      }else if (_selectedIndex == 5)//3
       {

      return const AllUsersPage();
    } else if (_selectedIndex == 4) {
      return const ReportsPage();
    } else if (_selectedIndex == 3) //5 
    {
      //return const AllAssetsPage();
      final notifierGeneric = Provider.of<CreateNewScreenNotifier>(context);
      if(notifierGeneric.isMaintenancescreen){
      return MaintenancePage(callBack: _navigateToMaintenancePage);
      }
      else if (notifierGeneric.isAllVendors){
        return const AllVendorsPage();
      } 
      else if (notifierGeneric.isNewVendorPage){
        return const AddVendorPage();
      }
      else if (notifierGeneric.isAllBuildings){
        return  AllBuildingsPage(callBack: _navigateToViewandEditBuildingPage);
      }
      else if (notifierGeneric.isViewBuilding){
        return ViewBuildingPage(building: _attachedbuilding, isReadOnly: true, callBack: _navigateToViewandEditRoomPage);
      }
      else if (notifierGeneric.isRoomPage){
        return RoomPage(room: _attachedroom, isReadOnly: readOnly,);
      }
      // else if (notifierGeneric.isNewBuilding){
      //   return const AddBuildingPage();
      // }
      
      //const MaintenancePage();
    }

    return const HomePage();
  }

  void _navigateToAddAndEditAssetPage(String? profile) {
    setState(() {
      _isOnAssetProfilePage = true;
      _attachedprofile = profile;
    });
  }

  void _navigateToAddAndEditCheckOutPage(Object? asset) {
    setState(() {
      _isOnCheckOutPage = true;
      _attachedasset = asset;
    });
  }

  void _navigateToMaintenancePage(){
    setState(() {
      _isOnMaintenancePage = true;
    });
  }

  void _navigateToViewandEditBuildingPage(Building? building){
    setState(() {
      _attachedbuilding = building;
    });
  }

  void _navigateToViewandEditRoomPage(Room? room, bool viewOrEdit){
    setState(() {
      _attachedroom = room;
      readOnly = viewOrEdit;
    });
  }

  void onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
