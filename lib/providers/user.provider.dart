import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AppUser extends ChangeNotifier {


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


  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

//sign in
  Future<void> signIn( {required String email, required String password}) async {
    print('Email: $email');
    print('Password: $password');

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print('Sign in Succesful');

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw ('Wrong password provided for that user.');
      } else
        throw (e.toString());
    }
  }

  //sign out
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  //sign up
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


}

getUser() {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) print(user);
}
