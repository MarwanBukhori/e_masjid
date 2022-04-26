import 'dart:async';

import 'package:flutter/material.dart';
import 'package:e_masjid/widgets/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DermaScreen extends StatefulWidget {


  static const String routeName = '/lol';



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

  late final String url;

  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Derma'),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}