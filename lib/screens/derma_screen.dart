import 'dart:async';

import 'package:flutter/material.dart';
import 'package:e_masjid/widgets/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

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

  late final String url;

  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl:
        'https://dev.toyyibpay.com/derma-masjid-halim-shah',
        onWebViewCreated: (controller) {
          this.controller = controller;
        },
        onPageStarted: (url) {
          try {
            if (url.contains(
                'https://dev.toyyibpay.com/derma-masjid-halim-shah')) {
              Future.delayed(Duration(milliseconds: 200), () {
                //remove header
                controller.runJavascript(
                    "document.getElementsByTagName('header')[0].style.display='none'");
                //remove footer
                controller.runJavascript(
                    "document.getElementsByTagName('footer')[0].style.display='none'");
              });
            }
          } catch (e) {
            print(e);
            Text('error');
          }
        },
      ),
    );
  }
}

