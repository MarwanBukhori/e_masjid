import 'package:e_masjid/config/constants.dart';
import 'package:e_masjid/models/temujanji_model.dart';
import 'package:flutter/material.dart';
import 'package:e_masjid/widgets/widgets.dart';

import '../../services/temujanji.service.dart';
import '../../widgets/loading-indicator.dart';

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
  final tajukTextController = new TextEditingController();

  final huraianTextController = new TextEditingController();

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
          // TextField(
          //           //   decoration: InputDecoration(
          //           //     prefixIcon: Icon(Icons.people),
          //           //     border: OutlineInputBorder(),
          //           //     labelText: 'Imam Pilihan',
          //           //   ),
          //           // ),
          // SizedBox(
          //   height: 24,
          // ),
          TextField(
            controller: tajukTextController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.book_rounded),
              border: OutlineInputBorder(),
              labelText: 'Tajuk',
            ),
          ),
          SizedBox(
            height: 24,
          ),
          TextField(
            controller: huraianTextController,
            maxLines: 4,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Huraian',
              hintText: 'Tulis sesuatu..',
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                icon: Icon(
                    Icons.add_box,
                size: 27.0,),
                style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    textStyle:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                onPressed: () async {
                  try {
                    LoadingIndicator.showLoadingDialog(context);

                    final temujanji = TemuJanji(
                        TemuJanjiID: 'TJ2',
                        JenisTemuJanji: 'tanya',
                        tajuk: tajukTextController.text,
                        huraian: huraianTextController.text,
                        tarikh: DateTime.now()
                    );

                    final result = await addTask(temujanji);

                    if (result) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } else
                      throw 'Unable to add soalan';
                  } catch (e) {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text(e.toString()),
                        );
                      },
                    );
                  }
                  ;
                },
                label: Text('Hantar Soalan'),
              )
            ],
          )
        ]),
      ),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}
