import 'package:e_masjid/config/constants.dart';
import 'package:e_masjid/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:e_masjid/widgets/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../services/firestore_service.dart';

class TempahQurbanScreen extends StatefulWidget {
  const TempahQurbanScreen({Key? key}) : super(key: key);
  static const String routeName = '/qurban';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => TempahQurbanScreen(),
    );
  }

  @override
  _TempahQurbanScreenState createState() => _TempahQurbanScreenState();
}

class _TempahQurbanScreenState extends State<TempahQurbanScreen> {
  FireStoreService fireStoreService = FireStoreService();

  final pemohonController = TextEditingController();
  final bahagianController = TextEditingController();

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
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            'Tempah',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 25.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            'Qurban',
            style: TextStyle(
                color: Colors.black87,
                fontSize: 35.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                margin: EdgeInsets.all(20.w),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: kZambeziColor, width: 1),
                  borderRadius: BorderRadius.circular(20.w),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 0, top: 5, right: 8, bottom: 5),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.person,
                                  color: Colors.lightBlue,
                                ),
                                SizedBox(
                                  width: 9.w,
                                ),
                                Text(
                                  'Pemohon',
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            controller: pemohonController,
                            autofocus: false,
                            cursorColor: kZambeziColor,
                            keyboardType: TextInputType.name,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              RegExp regex = RegExp(r'^.{5,}$');
                              if (value!.isEmpty) {
                                return ("Sila isi nama pemohon");
                              }

                              return null;
                            },
                            onSaved: (value) {
                              pemohonController.text = value!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              labelText: 'Nama penuh pemohon',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Bahagian
                          Row(
                            children: [
                              const Icon(
                                Icons.shopping_cart,
                                color: Colors.black54,
                              ),
                              SizedBox(
                                width: 9.w,
                              ),
                              Text(
                                'Bahagian',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),

                            ],
                          ),
                          const SizedBox(height: 10),
                          // button Bahagian
                          TextFormField(
                            controller: bahagianController,
                            autofocus: false,
                            cursorColor: kZambeziColor,
                            keyboardType: TextInputType.number,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              RegExp regex = RegExp(r'^.{5,}$');
                              if (value!.isEmpty) {
                                return ("Sila isi bilangan bahagian");
                              }

                              return null;
                            },
                            onSaved: (value) {
                              bahagianController.text = value!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              labelText: 'Bahagian qurban',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),

                          const SizedBox(
                            height: 15,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: kPrimaryColor),
                                  onPressed: () {
                                    addTempahQurban();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.add,
                                        color: Colors.green,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: kPrimaryColor),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.cancel,
                                        color: Colors.red,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ]),
      bottomNavigationBar: CustomNavBar(),
    );
  }

  void addTempahQurban() async {
    EasyLoading.show(status: 'sedang diproses...');

    int a = int.parse(bahagianController.text);
    await fireStoreService.uploadTempahQurban(pemohonController.text, a);

    EasyLoading.showSuccess('Tempahan berjaya ditambah');
    Navigator.of(context).popAndPushNamed('/semak');

    setState(() {});
  }
}
