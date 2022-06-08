import 'package:e_masjid/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:e_masjid/screens/screens.dart';
import 'package:e_masjid/providers/user.provider.dart';
import 'package:e_masjid/widgets/checkbox.dart';
import 'package:provider/provider.dart';
import 'package:e_masjid/widgets/signup_form.dart';
import 'package:e_masjid/services/firestore_service.dart';
import 'package:e_masjid/providers/user.provider.dart';

import '../../widgets/loading-indicator.dart';

class SignUpScreen extends StatelessWidget {
  String role = "kariah";

  AppUser appUser = AppUser();
  FireStoreService fireStoreService = FireStoreService();

  @override
  Widget build(BuildContext context) {

    final appUser = Provider.of<AppUser>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 70,
            ),
            Padding(
              padding: kDefaultPadding,
              child: Text(
                'Cipta Akaun',
                style: titleText,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: kDefaultPadding,
              child: Row(
                children: [
                  Text(
                    'Sudah menjadi ahli?',
                    style: subTitle,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: Text(
                      'Log Masuk',
                      style: textButton.copyWith(
                        decoration: TextDecoration.underline,
                        decorationThickness: 1,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: kDefaultPadding,
              child: SignUpForm(),
            ),
            SizedBox(
              height: 20,
            ),

            SizedBox(
              height: 20,
            ),

            Padding(
              padding: kDefaultPadding,
              child: GestureDetector(
                onTap: () async {
                  try {
                    LoadingIndicator.showLoadingDialog(context);

                    await AppUser.instance.signUp(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                    fireStoreService
                        .createUserData(nameController.text,
                        appUser.user!.uid, emailController.text,role);

                    Navigator.pop(context);
                    Navigator.pop(context);
                  } catch (e) {
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text(e.toString()),
                          );
                        });
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: kPrimaryColor),
                  child: Text(
                    'Daftar',
                    style: textButton.copyWith(color: kWhiteColor),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Padding(
            //   padding: kDefaultPadding,
            //   child: Text(
            //     'Or log in with:',
            //     style: subTitle.copyWith(color: kBlackColor),
            //   ),
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            Padding(
              padding: kDefaultPadding,
              // child: LoginOption(),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
