import 'package:flutter/material.dart';
import '../pages/all_users_page.dart';
import '../pages/asset_page.dart';

import 'pages/home_page.dart';
import 'pages/reservation_page.dart';
import 'sidebar.dart';
// import 'package:ocassetmanagement/sidebar.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  int _selectedIndex = 0;
  bool _showNavigationBar = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(199, 108, 13, 13),
        title: const Text(
          'OC Asset Management',
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () {
            setState(() {
              _showNavigationBar = !_showNavigationBar;
            });
          },
        ),

      ),
      // body: Placeholder(),
      body: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (_showNavigationBar)
            SideBar(
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
      return AssetPage();
    } else if (_selectedIndex == 3) {
      return ReservationsPage();
    }else if (_selectedIndex == 4) {
      return AllUsersPage();
    }

    return HomePage();
  }

  void onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}