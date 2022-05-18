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
        backgroundColor: kPrimaryColor,
        title: Center(child: Text('Hadis 40 Pilihan')),
      ),
      body: WebView(
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
    );
  }
}
