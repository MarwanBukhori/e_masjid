import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:e_masjid/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthService {
  bool LoggedIn = false;
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  //user authentication
  AppUser? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    LoggedIn = true;
    return AppUser(user.uid, user.email);
  }

  Stream<AppUser?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  //sign in function
  Future<AppUser?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    print(email);
    print(password);

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password
      );
      print('Sign in Sucessfully');

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw('Wrong password provided for that user.');
      } else
        throw(e.toString());
    }
  }

  //sign up function
  Future<AppUser?> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _userFromFirebase(credential.user);
  }

  //sign out
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();

  }
}


getUser(){
  final user = FirebaseAuth.instance.currentUser;
  if(user != null)
    print(user);
}
