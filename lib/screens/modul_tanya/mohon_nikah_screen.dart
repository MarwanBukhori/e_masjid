import 'package:flutter/material.dart';
import 'package:e_masjid/widgets/widgets.dart';
import 'package:e_masjid/config/constants.dart';

class MohonNikahScreen extends StatefulWidget {
  const MohonNikahScreen({Key? key}) : super(key: key);
  static const String routeName = '/nikah';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => MohonNikahScreen(),
    );
  }

  @override
  _MohonNikahScreenState createState() => _MohonNikahScreenState();
}

class _MohonNikahScreenState extends State<MohonNikahScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Mohon Nikah'),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(children: [
          SizedBox(
            height: 5,
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nama Pemohon',
            ),
          ),
          SizedBox(
            height: 24,
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nama Pasangan',
            ),
          ),
          SizedBox(
            height: 24,
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: kPrimaryColor,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      textStyle:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  onPressed: () {},
                  child: const Text('Hantar'))
            ],
          )
        ]),
      ),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}
