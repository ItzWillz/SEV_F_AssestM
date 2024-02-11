import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ocassetmanagement/screens/TempWebAuthPage.dart';
//import 'package:ocassetmanagement/landing.dart';
import 'package:ocassetmanagement/services/firestore_storage.dart';
import 'package:flutter/src/material/icons.dart';
//import 'package:sidebar.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCI4R27jYcZUT8osupWtDJH6S3N16vzUNM",
          authDomain: "ocassetmanagement.firebaseapp.com",
          projectId: "ocassetmanagement",
          storageBucket: "ocassetmanagement.appspot.com",
          messagingSenderId: "647960639907",
          appId: "1:647960639907:web:c1bb9c45af3f0a8cd64216",
          measurementId: "G-DLPHX1WD9Z"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OC Asset Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TempWebAuthPage(),
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

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
