import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ocassetmanagement/pages/landing.dart';
import 'package:ocassetmanagement/services/firestore_storage.dart';
import 'package:ocassetmanagement/view_models/logged_user.dart';
import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;

class TempWebAuthPage extends StatefulWidget {
  const TempWebAuthPage({super.key});

  @override
  State<TempWebAuthPage> createState() => _TempWebAuthPageState();
}

class _TempWebAuthPageState extends State<TempWebAuthPage> {
  User? user;
  String? accessToken;
  bool isLogin = true;
  bool validSchoolId = false;

  final myController = TextEditingController();

  FirestoreStorage firestoreStorage = FirestoreStorage();

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    myController.addListener(validateSchoolId);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    super.dispose();
  }

  GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    clientId:
        '647960639907-vre68aujh5n0go32sjb8arpame23sauf.apps.googleusercontent.com',
    scopes: [],
  );
  GoogleSignInAccount? _googleUser;

  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      return Scaffold(
        body: Center(
            child: Column(
          children: [
            ElevatedButton(
                onPressed: swapSignInMethod,
                child: const Text("Sign Up/Log In")),
            ElevatedButton(onPressed: login, child: const Text("Login")),
            const SizedBox(height: 10),
            Text(user?.uid ?? 'no uid'),
            const SizedBox(height: 10),
            Text(user?.email ?? ' no email'),
            const SizedBox(height: 10),
            Text(user?.toString() ?? 'no user'),
            const SizedBox(height: 10),
            Text(FirebaseAuth.instance.currentUser?.toString() ?? 'no user2'),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: signOut, child: const Text(" Sign out")),
          ],
        )),
      );
    } else {
      return Scaffold(
        body: Center(
            child: Column(
          children: [
            ElevatedButton(
                onPressed: swapSignInMethod,
                child: const Text("Sign Up/Log In")),
            SizedBox(
                width: 100,
                child: TextField(
                  controller: myController,
                  maxLength: 7,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: const InputDecoration(
                      labelText: "School ID", hintText: "1848375"),
                )),
            ElevatedButton(
                onPressed: validSchoolId ? signUp : null,
                child: const Text("Sign Up")),
            const SizedBox(height: 10),
            Text(user?.uid ?? 'no uid'),
            const SizedBox(height: 10),
            Text(user?.email ?? ' no email'),
            const SizedBox(height: 10),
            Text(user?.toString() ?? 'no user'),
            const SizedBox(height: 10),
            Text(FirebaseAuth.instance.currentUser?.toString() ?? 'no user2'),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: signOut, child: const Text(" Sign out")),
          ],
        )),
      );
    }
  }

// Login to already existing account.
  Future<void> login() async {
    try {
      _googleSignIn = GoogleSignIn(
        // Optional clientId
        clientId:
            '647960639907-vre68aujh5n0go32sjb8arpame23sauf.apps.googleusercontent.com',
        scopes: [],
      );

      _googleUser = await _googleSignIn.signIn();
      //print("This is the Google User $_googleUser");

      final GoogleSignInAuthentication? googleAuth =
          await _googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // To make it so FirebaseAuth accounts are ONLY CREATED on Sign-Up with a schoolId.
      if (await firestoreStorage.userExistsWithEmail(_googleUser!.email)) {
        final credentials =
            await FirebaseAuth.instance.signInWithCredential(credential);

        if (credentials.user != null) {
          notifyLogin(credentials.user!);
        }
      } else {
        throw "You must sign-up with a schoolId before logging in to your account.";
      }
    } on Exception catch (e) {
      // TODO
      //print('exception->$e');
    }
  }

// Signing-up new account requires schoolId to be supplied.
  Future<void> signUp() async {
    try {
      _googleSignIn = GoogleSignIn(
        // Optional clientId
        clientId:
            '647960639907-vre68aujh5n0go32sjb8arpame23sauf.apps.googleusercontent.com',
        scopes: [],
      );

      _googleUser = await _googleSignIn.signIn();

      final GoogleSignInAuthentication? googleAuth =
          await _googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final credentials =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (credentials.user != null) {
        notifySignUp(credentials.user!);
      }
    } on Exception catch (e) {
      // TODO
      print('exception->$e');
    }
  }

  void notifyLogin(User user) {
    final notifier = Provider.of<LoggedUserNotifier>(context, listen: false);
    // User? user = FirebaseAuth.instance.currentUser;
    notifier.completeLoginFunctionality(user);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const Landing()));
  }

  void notifySignUp(User user) {
    final notifier = Provider.of<LoggedUserNotifier>(context, listen: false);
    // User? user = FirebaseAuth.instance.currentUser;
    notifier.completeSignUpFunctionality(user, int.parse(myController.text));
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const Landing()));
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      setState(() {
        _googleUser = null;
      });
    } on Exception catch (_) {}
  }

  void swapSignInMethod() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  void validateSchoolId() {
    setState(() {
      if (myController.text.length == 7) {
        validSchoolId = true;
      } else {
        validSchoolId = false;
      }
    });
  }
}
