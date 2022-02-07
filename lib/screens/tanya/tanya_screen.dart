import 'package:flutter/material.dart';
import 'package:e_masjid/widgets/widgets.dart';

class TanyaScreen extends StatefulWidget {
  static const String routeName = '/tanya';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => TanyaScreen(),
    );
  }

  @override
  State<TanyaScreen> createState() => _TanyaScreenState();
}

class _TanyaScreenState extends State<TanyaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Tanya'),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}
