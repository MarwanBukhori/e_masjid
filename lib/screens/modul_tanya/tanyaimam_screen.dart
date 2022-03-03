import 'package:flutter/material.dart';
import 'package:e_masjid/widgets/widgets.dart';

class TanyaImamScreen extends StatefulWidget {

  const TanyaImamScreen({Key? key}) : super(key: key);
  static const String routeName = '/tanyaimam';

  static Route route(){
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => TanyaImamScreen(),
    );
  }

  @override
  _TanyaImamScreenState createState() => _TanyaImamScreenState();
}

class _TanyaImamScreenState extends State<TanyaImamScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Tanya Imam'),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}