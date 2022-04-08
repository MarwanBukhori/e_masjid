import 'package:flutter/material.dart';
import 'package:e_masjid/widgets/widgets.dart';

class DermaScreen extends StatefulWidget {
  static const String routeName = '/derma';

  static Route route(){
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => DermaScreen(),
    );
  }

  @override
  State<DermaScreen> createState() => _DermaScreenState();
}

class _DermaScreenState extends State<DermaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Derma'),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}