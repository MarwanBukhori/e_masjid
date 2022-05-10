import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreService {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  String error = "";

  Future<void> createUserData(
      String name, String userid, String email, String role) async {
    try {
      await _firebaseFirestore.collection("users").doc(userid).set({
        "email": email,
        "userid": userid,
        "name": name,
        "role": role,
      });
    } catch (e) {
      log(e.toString());
      error = e.toString();
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getdata() async {
    var data = await _firebaseFirestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    return data;
  }


  //used in edit_program.dart
  Future<DocumentSnapshot<Map<String, dynamic>>> getdataProgram(
      String id) async {
    var data =
    await _firebaseFirestore.collection("program").doc(id).get();
    return data;
  }


  //used in edit_program.dart
  Future<void> updateServiceData(
    String title,
    String desc,
    DateTime firstDate,
    DateTime lastDate,
    String id,
  ) async {
    await _firebaseFirestore.collection("program").doc(id).update({
      "title": title,
      "description": desc,
      "firstDate": firstDate,
      "lastDate" : lastDate
    });
  }

  // use in add Program screen
  Future<void> uploadProgramData(String title, String desc, DateTime firstDate, DateTime lastDate) async {
    // int intlastDate = lastDate.millisecondsSinceEpoch;

    await _firebaseFirestore.collection("program").doc().set({
      "title": title,
      "description": desc,
      "firstDate": firstDate,
      "lastDate" : lastDate
    });
  }

  // use in to add pertanyaan imam
  Future<void> uploadTanyaData(String title, String desc) async {
  DateTime date = DateTime.now();

    await _firebaseFirestore.collection("tanya").doc().set({
      "title": title,
      "description": desc,
      "date": date,
      "JenisTemuJanji" : "Pertanyaan",
      "balasan" : "",
      "isApproved" : false,
    });
  }
}
