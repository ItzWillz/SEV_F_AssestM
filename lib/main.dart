import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ocassetmanagement/pages/asset_profile_selection_page.dart';
// ignore: unused_import
import 'package:ocassetmanagement/pages/web_auth_page.dart';
// ignore: unused_import
import 'package:ocassetmanagement/services/firestore_storage.dart';
import 'package:ocassetmanagement/view_models/create_check_out.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'pages/landing.dart';
import 'view_models/create_asset_profile.dart';
import 'view_models/create_new_screen.dart';
import 'view_models/logged_user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<CreateAssetNotifier>(
          create: (_) => CreateAssetNotifier()),
      ChangeNotifierProvider<CreateCheckOutNotifier>(
          create: (_) => CreateCheckOutNotifier()),
      ChangeNotifierProvider<CreateNewScreenNotifier>(
          create: (_) => CreateNewScreenNotifier()),
      ChangeNotifierProvider<LoggedUserNotifier>(
          create: (_) => LoggedUserNotifier()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //primarySwatch: Colors.blue,
      ),

     //home: const Landing(),
      home: Provider.of<LoggedUserNotifier>(context).isLoggedIn
         ? const Landing()
          : const TempWebAuthPage(),
    );
  }
}
