import 'package:flutter/material.dart';
import 'package:e_masjid/config/constants.dart';
import 'package:e_masjid/providers/user.provider.dart';
import 'package:provider/provider.dart';

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AppUser>(context);

    return Column(
      children: [
        // buildInputForm('First Name', false),
        // buildInputForm('Last Name', false),
        buildInputForm('Email', false, emailController),
        // buildInputForm('Phone', false),
        buildInputForm('Password', true, passwordController),
        // buildInputForm('Confirm Password', true),
      ],
    );
  }

  Padding buildInputForm(String hint, bool pass, TextEditingController controller) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: TextFormField(
          controller: controller,
          obscureText: pass ? _isObscure : false,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: kTextFieldColor),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor)),
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
                ))
                : null,
          ),
        ));
  }
}