import 'package:flutter/material.dart';

class SideBar extends StatefulWidget {
  const SideBar({
    super.key,
    this.labelType = NavigationRailLabelType.all,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final NavigationRailLabelType labelType;
  final int selectedIndex;
  final void Function(int) onDestinationSelected;

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: widget.selectedIndex,
      labelType: widget.labelType,
      elevation: 5,
      onDestinationSelected: widget.onDestinationSelected,
      destinations: const <NavigationRailDestination>[
        NavigationRailDestination(
          icon: Icon(Icons.home),
          label: Text('Home'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.add_box_outlined),
          label: Text('Asset'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.person),
          label: Text('Users'),
        ),
      ],
    );
  }
}
