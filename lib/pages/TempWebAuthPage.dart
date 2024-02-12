import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:http/http.dart' as http;

class TempWebAuthPage extends StatefulWidget {
  const TempWebAuthPage({super.key});

  @override
  State<TempWebAuthPage> createState() => _TempWebAuthPageState();
}

class _TempWebAuthPageState extends State<TempWebAuthPage> {
  User? user;
  String? accessToken;

  GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    clientId:
        '647960639907-vre68aujh5n0go32sjb8arpame23sauf.apps.googleusercontent.com',
    scopes: [],
  );
  GoogleSignInAccount? _googleUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          ElevatedButton(onPressed: signIn, child: const Text("Sign in")),
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

  Future<void> signIn() async {
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

      await FirebaseAuth.instance.signInWithCredential(credential);
      setState(() {});
      // Navigate to Landing Page here
    } on Exception catch (e) {
      // TODO
      print('exception->$e');
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      setState(() {
        _googleUser = null;
      });
    } on Exception catch (_) {}
  }
}
