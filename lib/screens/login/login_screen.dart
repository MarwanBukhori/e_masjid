import 'package:e_masjid/widgets/loading-indicator.dart';
import 'package:flutter/material.dart';
import 'package:e_masjid/screens/screens.dart';
import 'package:e_masjid/config/constants.dart';
import 'package:e_masjid/widgets/login_form.dart';
import 'package:e_masjid/providers/user.provider.dart';
import 'package:provider/provider.dart';

import '../../providers/user.provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appUser = Provider.of<AppUser>(context);
    return Scaffold(
      body: Padding(
        padding: kDefaultPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 70,
              ),
              Center(child: Image.asset('assets/images/e_masjid1.jpg')),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Text(
                  'Selamat Datang.',
                  style: subTitle,
                ),
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
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Center(
                    child: Text(
                      'Daftar akaun!',
                      style: textButton.copyWith(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 7,
              ),
              LogInForm(),


              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgotPassword()));
                },
                child: Center(
                  child: Text(
                    'Terlupa kata laluan?',
                    style: TextStyle(
                      color: kZambeziColor,
                      fontSize: 14,
                      decorationThickness: 1,
                    ),
                  ),

                ),
              ),
              SizedBox(
                height: 20,
              ),


              GestureDetector(
                onTap: () async {
                  try {
                    LoadingIndicator.showLoadingDialog(context);
                    AppUser.instance.signIn(
                        email: emailController.text,
                        password: passwordController.text);
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
                  ;
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

            ],
          ),
        ),
      ),
    );
  }
}
