import 'package:flutter/material.dart';
import 'package:e_masjid/config/constants.dart';


final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController nameController = TextEditingController();

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool _isObscure = true;
  bool pass = true;
  bool notpass = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Nama",
                hintStyle: TextStyle(color: kTextFieldColor),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor)),
              ),
            )),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Emel",
                hintStyle: TextStyle(color: kTextFieldColor),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor)),
              ),
            )),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: TextFormField(
              controller: passwordController,
              obscureText: pass ? _isObscure : false,
              decoration: InputDecoration(
                hintText: "Kata Laluan",
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
            )),

        // buildInputForm('Email', false, emailController),
        // // buildInputForm('Phone', false),
        // buildInputForm('Password', true, passwordController),

        // buildInputForm('Confirm Password', true),
      ],
    );
  }
//
//   Padding buildInputForm(
//       String hint, bool pass, TextEditingController controller) {
//     return Padding(
//         padding: EdgeInsets.symmetric(vertical: 5),
//         child: TextFormField(
//           controller: controller,
//           obscureText: pass ? _isObscure : false,
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: TextStyle(color: kTextFieldColor),
//             focusedBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: kPrimaryColor)),
//             suffixIcon: pass
//                 ? IconButton(
//                     onPressed: () {
//                       setState(() {
//                         _isObscure = !_isObscure;
//                       });
//                     },
//                     icon: _isObscure
//                         ? Icon(
//                             Icons.visibility_off,
//                             color: kTextFieldColor,
//                           )
//                         : Icon(
//                             Icons.visibility,
//                             color: kPrimaryColor,
//                           ))
//                 : null,
//           ),
//         ));
//   }
// }
}