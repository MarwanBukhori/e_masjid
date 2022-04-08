import 'package:flutter/material.dart';
import 'package:e_masjid/screens/screens.dart';
import 'package:e_masjid/providers/user.provider.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appUser = Provider.of<AppUser>(context);

    if (appUser.user != null) {
      print('Logged in');
      return HomeScreen();
    } else {
      print('Not logged in');
      return LoginScreen();
    }
  }
}
    //
    // return StreamBuilder<AppUser?>(
    //   stream: authService.user,
    //   builder: (_, AsyncSnapshot<AppUser?> snapshot) {
    //     if (snapshot.connectionState == ConnectionState.active) {
    //       final AppUser? user = snapshot.data;
    //       return user == null ? LoginScreen() : HomeScreen();
    //     } else {
    //       return Scaffold(
    //         body: Center(
    //           child: CircularProgressIndicator(),
    //         ),
    //       );
    //     }
    //   },
    // );

