import 'package:firebase_auth/firebase_auth.dart';
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
    // Check to see if there is a user currently logged-in. If so, set the LoggedUserNotifier to reflect the user's data.
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final notifier = Provider.of<LoggedUserNotifier>(context, listen: false);
      notifier.completeLoginFunctionality(user);
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          //primarySwatch: Colors.blue,
          ),
      //home: const NewCheckOutPage(),

      //home: const Landing(),
      home: user != null ? const Landing() : const TempWebAuthPage(),
    );
  }
}
