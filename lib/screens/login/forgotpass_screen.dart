import 'package:e_masjid/screens/screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../config/constants.dart';
import '../../providers/user.provider.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();

  final emailController = new TextEditingController();

  AppUser appUser = AppUser();

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Tetapan semula kata laluan'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30),
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/e_masjid1.jpg",

                ),
                Text(
                  'Terima emel untuk menetapkan semula kata laluan anda',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: 'Emel',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Sila isi butiran emel");
                    }
                    // reg expression for email validation
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return ("Sila masukkan emel yang sah");
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(25.0)),
                      primary: kPrimaryColor,
                      minimumSize: Size.fromHeight(50),
                    ),
                    icon: Icon(Icons.email),
                    label: Text(
                      'Tetap semula kata laluan',
                      style: TextStyle(fontSize: 17),
                    ),
                    onPressed: () {
                      if (emailController.text == "") {
                        EasyLoading.showError('Sila isi butiran emel');
                      }else{
                        resetPassword();
                      }

                    }),
                SizedBox(height: 30),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text("Kembali ke", style: TextStyle(
                    fontSize: 14,

                  ),),
                  TextButton(
                      onPressed: () {
                        //button to new screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      child: Text(
                        "Log masuk ",
                        style: TextStyle(color: kPrimaryColor),
                      ))
                ]),
              ],
            )
        ),
      ),
    );
  }

  Future resetPassword() async {
    String error = "";

    EasyLoading.show(status: 'sedang diproses..');

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());

      EasyLoading.showSuccess('Penetapan semula kata laluan telah dihantar');
      EasyLoading.dismiss();
    } on FirebaseAuthException catch (e) {
      print(e);
      e.toString();

      EasyLoading.showToast(error);
      Navigator.of(context).pop();
    }
  }
}