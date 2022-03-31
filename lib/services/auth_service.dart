import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:e_masjid/models/user_model.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;


  //user authentication
  User? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return User(user.uid, user.email);
  }

  Stream<User?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  //sign in function
  Future<User?> signInWithEmailAndPassword(
      String email,
      String password,
      ) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _userFromFirebase(credential.user);
  }

  //sign up function
  Future<User?> createUserWithEmailAndPassword(
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