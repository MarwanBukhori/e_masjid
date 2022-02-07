import 'package:flutter/material.dart';
import 'package:e_masjid/widgets/widgets.dart';

class ProgramScreen extends StatefulWidget {
  static const String routeName = '/program';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => ProgramScreen(),
    );
  }

  @override
  State<ProgramScreen> createState() => _ProgramScreenState();
}

class _ProgramScreenState extends State<ProgramScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Program'),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}
