import 'package:e_masjid/screens/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:e_masjid/widgets/widgets.dart';
import 'package:e_masjid/config/constants.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:e_masjid/providers/user.provider.dart';

import '../../services/firestore_service.dart';
import '../../providers/user.provider.dart';

class AdminHomeScreen extends StatefulWidget {

  static const String routeName = '/admin_home';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => AdminHomeScreen(),
    );
  }

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Admin'),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}



