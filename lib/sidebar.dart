//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SideBar extends StatefulWidget {
  SideBar({
    super.key,
    this.labelType = NavigationRailLabelType.all,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.userGroup,
  });

  final NavigationRailLabelType labelType;
  final int selectedIndex;
  // ignore: prefer_typing_uninitialized_variables
  final userGroup;
  List<NavigationRailDestination> navigationDestinations = [];
  final void Function(int) onDestinationSelected;

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {

  @override
  Widget build(BuildContext context) {
    // List<NavigationRailDestination>? navigationDestinations = [];
    if (widget.userGroup.toString() == 'Admin') {
      widget.navigationDestinations = [
        const NavigationRailDestination(
          icon: Icon(Icons.home),
          label: Text('Home'),
        ),
        const NavigationRailDestination(
          icon: Icon(Icons.list),
          label: Text('All Assets'),
        ),
        const NavigationRailDestination(
          icon: Icon(Icons.checklist),
          label: Text("Check In/Out"),
        ),
        const NavigationRailDestination(
          icon: Icon(Icons.person),
          label: Text('Users'),
        ),
        const NavigationRailDestination(
          icon: Icon(Icons.query_stats),
          label: Text('Reports'),
        ),
        const NavigationRailDestination(
          icon: Icon(Icons.settings),
          label: Text('Maintenance'),
        )
        
      ];
    } else {
      widget.navigationDestinations = [
        const NavigationRailDestination(
          icon: Icon(Icons.home),
          label: Text('Home'),
        ),
        const NavigationRailDestination(
          //icon: Icon(Icons.add_box_outlined),
          icon: Icon(Icons.list),
          label: Text('All Asset'),
        ),
        const NavigationRailDestination(
          icon: Icon(Icons.checklist),
          label: Text("Check In/Out"),
        ),
        const NavigationRailDestination(
          icon: Icon(Icons.settings),
          label: Text('Maintenance'),
        )
      ];
    }

    return NavigationRail(
      indicatorColor: const Color.fromARGB(111, 108, 13, 13),
      selectedIndex: widget.selectedIndex,
      labelType: widget.labelType,
      elevation: 5,
      onDestinationSelected: widget.onDestinationSelected,
      destinations: widget.navigationDestinations,
    );
  }
}

