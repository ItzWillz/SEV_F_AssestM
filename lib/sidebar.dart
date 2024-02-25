import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
  final userGroup;
  List<NavigationRailDestination> navigationDestinations = [];
  final void Function(int) onDestinationSelected;


  @override
  State<SideBar> createState() => _SideBarState();
}



class _SideBarState extends State<SideBar> {
//   List get navigationDestinations => navigationDestinations;
//   set navigationDestinations( navigationDestinations) {
// if (widget.userGroup.toString() == 'Admin'){
//  this.navigationDestinations = [
//    const NavigationRailDestination(
//           icon: Icon(Icons.home),
//           label: Text('Home'),
//         ),
//         const NavigationRailDestination(
//           icon: Icon(Icons.add_box_outlined),
//           label: Text('Asset'),
//         ),
//          const NavigationRailDestination(
//           icon: Icon(Icons.checklist),
//           label: Text("Check In/Out"),
//         ),
//         const NavigationRailDestination(
//           icon: Icon(Icons.person),
//           label: Text('Users'),
//         ),const NavigationRailDestination(
//           icon: Icon(Icons.query_stats),
//           label: Text('Reports'),
//         ),
//  ];
//     } else {
//            navigationDestinations = [
//         const NavigationRailDestination(
//           icon: Icon(Icons.home),
//           label: Text('Home'),
//         ),
//         const NavigationRailDestination(
//           icon: Icon(Icons.add_box_outlined),
//           label: Text('Asset'),
//         ),
//          const NavigationRailDestination(
//           icon: Icon(Icons.checklist),
//           label: Text("Check In/Out"),
//         ),
//            ];
//         }


  @override
  Widget build(BuildContext context) {
   // List<NavigationRailDestination>? navigationDestinations = []; 
if (widget.userGroup.toString() == 'Admin'){
 widget.navigationDestinations = [
   const NavigationRailDestination(
          icon: Icon(Icons.home),
          label: Text('Home'),
        ),
        const NavigationRailDestination(
          icon: Icon(Icons.add_box_outlined),
          label: Text('Asset'),
        ),
         const NavigationRailDestination(
          icon: Icon(Icons.checklist),
          label: Text("Check In/Out"),
        ),
        const NavigationRailDestination(
          icon: Icon(Icons.person),
          label: Text('Users'),
        ),const NavigationRailDestination(
          icon: Icon(Icons.query_stats),
          label: Text('Reports'),
        ),
 ];
    } else {
           widget.navigationDestinations = [
        const NavigationRailDestination(
          icon: Icon(Icons.home),
          label: Text('Home'),
        ),
        const NavigationRailDestination(
          icon: Icon(Icons.add_box_outlined),
          label: Text('Asset'),
        ),
         const NavigationRailDestination(
          icon: Icon(Icons.checklist),
          label: Text("Check In/Out"),
        ),
           ];
        }

    return NavigationRail(
      selectedIndex: widget.selectedIndex,
      labelType: widget.labelType,
      elevation: 5,
      onDestinationSelected: widget.onDestinationSelected,
      destinations: widget.navigationDestinations,
      // const <NavigationRailDestination>[
      //   NavigationRailDestination(
      //     icon: Icon(Icons.home),
      //     label: Text('Home'),
      //   ),
      //   NavigationRailDestination(
      //     icon: Icon(Icons.add_box_outlined),
      //     label: Text('Asset'),
      //   ),
      //    NavigationRailDestination(
      //     icon: Icon(Icons.checklist),
      //     label: Text("Check In/Out"),
      //   ),
      //   // NavigationRailDestination(
      //   //   icon: Icon(Icons.edit_document),
      //   //   label: Text("Reservations"),
      //   // ),
      //   NavigationRailDestination(
      //     icon: Icon(Icons.person),
      //     label: Text('Users'),
      //   ),NavigationRailDestination(
      //     icon: Icon(Icons.query_stats),
      //     label: Text('Reports'),
      //   ),
       
     //],
    );
  }
}

//List navigationDestinations = [];

 