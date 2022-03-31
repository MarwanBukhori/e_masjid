import 'package:flutter/material.dart';
import 'package:e_masjid/widgets/widgets.dart';
import 'package:e_masjid/utils/constants.dart';

class TempahQurbanScreen extends StatefulWidget {

  const TempahQurbanScreen({Key? key}) : super(key: key);
  static const String routeName = '/qurban';

  static Route route(){
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => TempahQurbanScreen(),
    );
  }

  @override
  _TempahQurbanScreenState createState() => _TempahQurbanScreenState();
}

class _TempahQurbanScreenState extends State<TempahQurbanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Qurban'),
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
              labelText: 'Kuantiti Slot/Bahagian',
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
                  child: const Text('Tempah'))
            ],
          )
        ]),
      ),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}