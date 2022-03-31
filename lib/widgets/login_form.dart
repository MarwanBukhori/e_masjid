import 'package:flutter/material.dart';
import 'package:e_masjid/utils/constants.dart';

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class LogInForm extends StatefulWidget {

  @override
  _LogInFormState createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {

  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        buildInputForm('Email', false, emailController),
        buildInputForm('Password', true, passwordController),
      ],
    );
  }

  Padding buildInputForm(String label, bool pass, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: controller,
        obscureText: pass ? _isObscure : false,
        decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              color: kTextFieldColor,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor),
            ),
            suffixIcon: pass
                ? IconButton(
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
              icon: _isObscure
                  ? Icon(
                Icons.visibility_off,
                color: kTextFieldColor,
              )
                  : Icon(
                Icons.visibility,
                color: kPrimaryColor,
              ),
            )
                : null),
      ),
    );
  }
}