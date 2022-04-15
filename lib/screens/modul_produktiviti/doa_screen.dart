import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DoaScreen extends StatefulWidget {
  static const String routeName = '/doa';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => DoaScreen(),
    );
  }

  @override
  State<DoaScreen> createState() => _DoaScreenState();
}

class _DoaScreenState extends State<DoaScreen> {
  @override
  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(child: Text('Doa-Doa Harian')),
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl:
        'https://akuislam.com/blog/ibadah/doa-harian/',
        onWebViewCreated: (controller) {
          this.controller = controller;
        },
        onPageStarted: (url) {
          try {
            if (url.contains(
                'https://akuislam.com/blog/ibadah/doa-harian/')) {
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
