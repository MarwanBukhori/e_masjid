import 'package:e_masjid/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:e_masjid/screens/screens.dart';
import 'package:e_masjid/services/auth_service.dart';
import 'package:e_masjid/widgets/checkbox.dart';
import 'package:provider/provider.dart';
import 'package:e_masjid/widgets/primary_button.dart';
import 'package:e_masjid/widgets/signup_form.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
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
            Padding(
              padding: kDefaultPadding,
              child: CheckBox('Setuju dengan terma dan syarat.'),
            ),
            SizedBox(
              height: 20,
            ),
            // Padding(
            //   padding: kDefaultPadding,
            //   child: CheckBox('I have at least 18 years old.'),
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            Padding(
              padding: kDefaultPadding,
              child: GestureDetector(
                onTap: () async {
                  print('Sign up button clicked');
                  await authService.createUserWithEmailAndPassword(
                    emailController.text,
                    passwordController.text,
                  );
                  Navigator.pop(context);
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
