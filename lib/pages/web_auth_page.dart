import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ocassetmanagement/pages/landing.dart';
import 'package:ocassetmanagement/services/firestore_storage.dart';
import 'package:ocassetmanagement/view_models/logged_user.dart';
import 'package:provider/provider.dart';

import '../services/image_converter.dart';
// import 'package:http/http.dart' as http;

class TempWebAuthPage extends StatefulWidget {
  const TempWebAuthPage({super.key});

  @override
  State<TempWebAuthPage> createState() => _TempWebAuthPageState();
}

class _TempWebAuthPageState extends State<TempWebAuthPage> {
  User? user;
  String? accessToken;
  bool isLogin = false;
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
    // Check to see if there is a user currently logged-in. If so, call function to login the user.
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      notifyLogin(user);
      return Text("User already logged-in. Redirecting.");
    }

    // No currently logged-in user. Display sign-up/login form.
    else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(199, 108, 13, 13),
          title: const Text(
            'OC Asset Management System',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: convertToImage('assets/campus.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Card(
              color: Colors.white,
              child: SizedBox(
                width: 300,
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Text(
                        'Sign In',
                        style: TextStyle(fontSize: 22.0),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Column(
                          children: [
                            ElevatedButton(
                                onPressed: swapSignInMethod,
                                child: const Text("Sign Up/Log In")),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                                width: 100,
                                child: Visibility(
                                  visible: isLogin,
                                  child: Column(
                                    children: [
                                      TextField(
                                        controller: myController,
                                        maxLength: 7,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: const InputDecoration(
                                            labelText: "School ID",
                                            hintText: "ex. 1848375"),
                                      ),
                                      ElevatedButton(
                                          onPressed:
                                              validSchoolId ? signUp : null,
                                          child: const Text("Sign Up")),
                                    ],
                                  ),
                                )),
                            Visibility(
                                visible: !isLogin,
                                child: Column(
                                  children: [
                                    ElevatedButton(
                                        onPressed: login,
                                        child: const Text("Login with Google")),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
          ),
        ),
      );
      //  } else {
      //   return Scaffold(
      //     body: Center(
      //         child: Column(
      //       children: [
      //         ElevatedButton(
      //             onPressed: swapSignInMethod,
      //             child: const Text("Sign Up/Log In")),
      //         SizedBox(
      //             width: 100,
      //             child: TextField(
      //               controller: myController,
      //               maxLength: 7,
      //               inputFormatters: <TextInputFormatter>[
      //                 FilteringTextInputFormatter.digitsOnly
      //               ],
      //               decoration: const InputDecoration(
      //                   labelText: "School ID", hintText: "ex. 1848375"),
      //             )),
      //         ElevatedButton(
      //             onPressed: validSchoolId ? signUp : null,
      //             child: const Text("Sign Up")),
      //         const SizedBox(height: 10),
      //         Text(user?.uid ?? 'no uid'),
      //         const SizedBox(height: 10),
      //         Text(user?.email ?? ' no email'),
      //         const SizedBox(height: 10),
      //         Text(user?.toString() ?? 'no user'),
      //         const SizedBox(height: 10),
      //         Text(FirebaseAuth.instance.currentUser?.toString() ?? 'no user2'),
      //         const SizedBox(height: 10),
      //         ElevatedButton(onPressed: signOut, child: const Text(" Sign out")),
      //       ],
      //     )),
      //   );
      // }
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
      // ignore: unused_catch_clause
    } on Exception catch (e) {
      // Hold Empty
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
      // ignore: unused_catch_clause
    } on Exception catch (e) {
      // Hold Empty
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

// TODO: Throw exception if error.
  void signOut() {
    final notifier = Provider.of<LoggedUserNotifier>(context, listen: false);
    notifier.loggedUserOut();
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
