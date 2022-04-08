import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppUser extends ChangeNotifier {
  bool loggedIn = false;

  update() {
    notifyListeners();
  }

  AppUser._() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      notifyListeners();
    });
  }

  User? get user => FirebaseAuth.instance.currentUser;

  factory AppUser() => AppUser._();

  static AppUser get instance => AppUser();

  bool LoggedIn = false;
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;


  Future<void> signIn(BuildContext context, {required String email, required String password}) async {
    print('Email: $email');
    print('Password: $password');

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print('Sign in Succesful');
      Provider.of<AppUser>(context,  listen: false).loggedIn = true;


    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw ('Wrong password provided for that user.');
      } else
        throw (e.toString());
    }
  }

  Future<bool> signUp({
    required String email,
    required String password,
    // required String name,
  }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      // user!.updateDisplayName(name);
      return true;
    } catch (e) {
      throw (e);
    }
  }

  //sign out
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}

getUser() {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) print(user);
}
