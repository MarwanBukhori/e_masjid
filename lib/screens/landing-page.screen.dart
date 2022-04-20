import 'package:flutter/material.dart';
import 'package:e_masjid/screens/screens.dart';
import 'package:e_masjid/providers/user.provider.dart';
import 'package:provider/provider.dart';

import '../services/firestore_service.dart';

class LandingScreen extends StatelessWidget {
  LandingScreen({Key? key}) : super(key: key);

  String role = "";

  FireStoreService fireStoreService = FireStoreService();

  @override
  Widget build(BuildContext context) {
    final appUser = Provider.of<AppUser>(context);

    fireStoreService.getdata().then((value) {
      role = value.data()!["role"];
    });


    if (appUser.user != null) {
      if (role == "kariah") {
        print(role);
        print('Logged in as Kariah');
        return HomeScreen();
      } else {
        print(role);
        print('Logged in as Petugas');
        return HomeScreen();
      }
    } else {
      print('Not logged in hehe');
      return LoginScreen();
    }
  }
}
