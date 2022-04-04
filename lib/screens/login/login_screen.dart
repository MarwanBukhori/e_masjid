import 'package:flutter/material.dart';
import 'package:e_masjid/screens/screens.dart';
import 'package:e_masjid/config/constants.dart';
import 'package:e_masjid/widgets/login_form.dart';
import 'package:e_masjid/providers/auth_service.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      body: Padding(
        padding: kDefaultPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Center(child: Image.asset('assets/emasjid.png')),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    'Selamat Datang!',
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
                          builder: (context) => SignUpScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Daftar akaun.',
                      style: textButton.copyWith(
                        decoration: TextDecoration.underline,
                        decorationThickness: 1,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              LogInForm(),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => ResetPasswordScreen()));
                  //
                },
                child: Text(
                  'Terlupa kata laluan?',
                  style: TextStyle(
                    color: kZambeziColor,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                    decorationThickness: 1,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              GestureDetector(
                onTap: () {
                  print('Sign in button clicked');
                  authService.signInWithEmailAndPassword(
                      emailController.text, passwordController.text);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: kPrimaryColor),
                  child: Text(
                    'Log Masuk',
                    style: textButton.copyWith(color: kWhiteColor),
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),
              // Text(
              //   'Or log in with:',
              //   style: subTitle.copyWith(color: kBlackColor),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // LoginOption(),
            ],
          ),
        ),
      ),
    );
  }
}
