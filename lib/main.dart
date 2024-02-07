import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ocassetmanagement/landing.dart';
import 'package:ocassetmanagement/services/firestore_storage.dart';
import 'package:flutter/src/material/icons.dart';
import 'package:sidebar.dart';

import 'firebase_options.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Landing(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//     FirestoreStorage().insertTask(_counter);
//   }

//   int _selectedIndex = 0;
//   bool showNavigationBar = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//         leading: IconButton(
//           icon: const Icon(
//             Icons.menu,
//             color: Colors.black,
//           ),
//           onPressed: () {
//             setState(() {
//               showNavigationBar = !showNavigationBar;
//             });
//           },
//         ),
//       ),
//       body: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           NavigationRail(
//             onDestinationSelected: (int index) {
//               setState(() {
//                 _selectedIndex = index;
//               });
//             },
//             destinations: const [
//               NavigationRailDestination(
//                 icon: Icon(Icons.home),
//                 label: Text('Home'),
//               ),
//               NavigationRailDestination(
//                 icon: Icon(Icons.add_box_outlined),
//                 label: Text('Asset'),
//               ),
//               NavigationRailDestination(
//                 icon: Icon(Icons.person),
//                 label: Text('Users'),
//               ),
//             ],
//             selectedIndex: _selectedIndex,
//             // labelType: labelType,
//           ),
//         ],
//       ),
      //  Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       const Text(
      //         'You have pushed the button this many times:',
      //       ),
      //       Text(
      //         '$_counter',
      //         style: Theme.of(context).textTheme.headlineMedium,
      //       ),
      //     ElevatedButton(
      //   onPressed: () {
      //     Navigator.push(context, MaterialPageRoute(builder: (context) => Landing()),);
      //   },
      //   child: Text('Landing'),
      // ),

      // ],
      //  ),
      // ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
//     );
//   }
// }
