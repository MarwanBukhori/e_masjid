import 'package:flutter/material.dart';
import 'package:e_masjid/widgets/widgets.dart';
import 'package:e_masjid/config/constants.dart';

import '../../models/temujanji_model.dart';
import '../../services/temujanji.service.dart';
import '../../widgets/loading-indicator.dart';

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

    final tajukTextController = new TextEditingController();

    final huraianTextController = new TextEditingController();

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
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
        body: ListView(
          children: <Widget>[
            SizedBox(height: 15.0),
            Padding(
              padding: const EdgeInsets.only(left: 20 ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:<Widget>[
                    Text(
                      'Mohon',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 25.0,
                      ),
                    ),
                    Text(
                      'Nikah',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    )
                  ]
              ),
            ),
            Container(
              padding: EdgeInsets.all(15.0),
              child: Column(children: [
                TextField(
                  controller: tajukTextController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.edit_note_outlined),
                    border: OutlineInputBorder(),
                    labelText: 'Nama Pemohon',
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                TextField(
                  controller: huraianTextController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nama Pasangan'
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      icon: Icon(
                        Icons.add,
                        size: 27.0,
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: kPrimaryColor,
                          padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                          textStyle: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      onPressed: () async {
                        try {
                          // LoadingIndicator.showLoadingDialog(context);
                          //
                          // final temujanji = TemuJanji(
                          //     TemuJanjiID: 'TJ2',
                          //     JenisTemuJanji: 'tanya',
                          //     tajuk: tajukTextController.text,
                          //     huraian: huraianTextController.text,
                          //     tarikh: DateTime.now());
                          //
                          // final result = await addTask(temujanji);
                          //
                          // if (result) {
                          //   Navigator.pop(context);
                          //   Navigator.pop(context);
                          // } else
                          //   throw 'Unable to add soalan';
                        } catch (e) {
                          // Navigator.pop(context);
                          // showDialog(
                          //   context: context,
                          //   builder: (context) {
                          //     return AlertDialog(
                          //       content: Text(e.toString()),
                          //     );
                          //   },
                          // );
                        }
                        ;
                      },
                      label: Text('Hantar Permohonan'),
                    )
                  ],
                )
              ]),
            ),
          ],
        ),
        bottomNavigationBar: CustomNavBar(),
      );
    }
}
