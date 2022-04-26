import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../services/PaypalPayment.dart';

class makePayment extends StatefulWidget {

  static const String routeName = '/derma';


  static Route route(){
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => makePayment(),
    );
  }


  @override
  _makePaymentState createState() => _makePaymentState();
}

class _makePaymentState extends State<makePayment> {
  TextStyle style = TextStyle(fontFamily: 'Open Sans', fontSize: 15.0);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _amountController = new TextEditingController();

  // show dialog for input of amount to top up account
  enterAmount() => showDialog(
        context: context,
        builder: (BuildContext context) => new AlertDialog(
          title: new Text('Enter amount'),
          content: new TextField(
            controller: _amountController,
            maxLines: 1,
            decoration: InputDecoration(
              hintText: "e.g. 10",
              labelText: "Amount",
            ),
            keyboardType: TextInputType.number,
          ),
          actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: new Text('CANCEL')),
            new FlatButton(
                onPressed: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => PaypalPayment(
                        _amountController.text,

                        onFinish: (number) async {
                          // payment done
                          print('order id: ' + number);
                        },
                      ),
                    ),
                  );
                },
                child: new Text('TOP UP')),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
          key: _scaffoldKey,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(45.0),
            child: new AppBar(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Top Up Example with WebView',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Open Sans'),
                  ),
                ],
              ),
            ),
          ),
          body: Container(
              width: MediaQuery.of(context).size.width,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        // enter amount to top up
                        enterAmount();
                      },
                      child: Text(
                        'Top Up Account',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              )),
        ));
  }
}
