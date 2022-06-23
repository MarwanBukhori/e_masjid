import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../config/constants.dart';

class HadisScreen extends StatefulWidget {
  static const String routeName = '/hadis';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => HadisScreen(),
    );
  }

  @override
  State<HadisScreen> createState() => _HadisScreenState();
}

class _HadisScreenState extends State<HadisScreen> {
  @override
  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(right: 50.0, top: 15),
          child: Center(
              child: Image.asset(
                'assets/images/e_masjid.png',
                height: 50,
              )),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black87,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl:
              'http://tintafaruq.blogspot.com/p/hadis-1-amal-dimulakan-dengan-niat.html',
          onWebViewCreated: (controller) {
            this.controller = controller;
          },
          onPageStarted: (url) {
            try {
              if (url.contains(
                  'http://tintafaruq.blogspot.com/p/hadis-1-amal-dimulakan-dengan-niat.html')) {
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
      ),
    );
  }
}
