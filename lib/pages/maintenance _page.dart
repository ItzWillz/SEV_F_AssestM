import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/create_new_screen.dart';

class MaintenancePage extends StatefulWidget {

  const MaintenancePage({super.key, required this.callBack});
  final void Function() callBack;

  @override
  State<MaintenancePage> createState() => _MaintenancePageState();
}



class _MaintenancePageState extends State<MaintenancePage> {

Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: const Text("Maintenance", style: TextStyle(fontSize: 30),),),
      body: Material(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  
                    children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(onPressed: () {
                      final notifier = Provider.of<CreateNewScreenNotifier>(context, listen: false);
                                  notifier.newScreen();
                    }, child: const Text("Vendors")),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(onPressed: () {}, child: const Text("Buildings & Rooms")),
                  )
                  ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  
                    children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(onPressed: () {}, child: const Text("Hold")),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(onPressed: () {}, child: const Text("Hold")),
                  )
                  ],
                  ),
                ),
              ],
            ),
          ),

      ),
    );

}

}