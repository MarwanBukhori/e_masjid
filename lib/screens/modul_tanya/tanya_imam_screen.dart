import 'package:e_masjid/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:e_masjid/widgets/widgets.dart';

class TanyaImamScreen extends StatefulWidget {
  const TanyaImamScreen({Key? key}) : super(key: key);
  static const String routeName = '/tanya';

  static Route route() {
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Center(
            child: Padding(
          padding: const EdgeInsets.only(right: 30.0),
          child: Text(
            'Tanya Imam',
          ),
        )),
        backgroundColor: kPrimaryColor,
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(children: [
          SizedBox(
            height: 5,
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Imam Pilihan',
            ),
          ),
          SizedBox(
            height: 24,
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Subjek',
            ),
          ),
          SizedBox(
            height: 24,
          ),
          TextField(
            maxLines: 4,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Mesej',
              hintText: 'Tulis sesuatu..',
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: kPrimaryColor,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  onPressed: () {}, child: const Text('Hantar'))
            ],
          )
        ]),
      ),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}
