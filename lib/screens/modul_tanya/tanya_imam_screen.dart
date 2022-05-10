import 'package:e_masjid/config/constants.dart';
import 'package:e_masjid/models/temujanji_model.dart';
import 'package:flutter/material.dart';
import 'package:e_masjid/widgets/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../services/firestore_service.dart';
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
  FireStoreService fireStoreService = FireStoreService();
  DateTimeRange dateRange =
      DateTimeRange(start: DateTime(2022, 11, 5), end: DateTime(2022, 12, 24));
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final DateController = TextEditingController();

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
            'Tanya',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 25.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            'Imam',
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
                    Container(
                      height: 15,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: kZambeziColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.w),
                          topRight: Radius.circular(20.w),
                        ),
                      ),
                    ),
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
                                  Icons.lightbulb_rounded,
                                  color: Colors.yellow,
                                ),
                                SizedBox(
                                  width: 7.w,
                                ),
                                Text(
                                  'Tajuk',
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
                            controller: titleController,
                            autofocus: false,
                            cursorColor: kZambeziColor,
                            keyboardType: TextInputType.name,
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              RegExp regex = RegExp(r'^.{5,}$');
                              if (value!.isEmpty) {
                                return ("Sila isi tajuk pertanyaan");
                              }
                              if (!regex.hasMatch(value)) {
                                return ("masukkan minimum 5 aksara");
                              }
                              return null;
                            },
                            onSaved: (value) {
                              titleController.text = value!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              contentPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              labelText: 'Cth : Apakah Hukum BitCoin..',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          const SizedBox(height: 15),

                          // Description
                          Row(
                            children: [
                              const Icon(
                                Icons.edit_note_outlined,
                                color: Colors.teal,
                              ),
                              SizedBox(
                                width: 7.w,
                              ),
                              Text(
                                'Huraian',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),

                          TextFormField(
                            controller: descController,
                            autofocus: false,
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.name,
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              RegExp regex = RegExp(r'^.{5,}$');
                              if (value!.isEmpty) {
                                return ("Sila isi huraian pertanyaan");
                              }
                              if (!regex.hasMatch(value)) {
                                return ("masukkan minimum 5 huruf");
                              }
                              return null;
                            },
                            onSaved: (value) {
                              descController.text = value!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              contentPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              labelText: 'Cth : Cryptocurrency ibarat cendawan tumbuh selepas hujan..',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          const SizedBox(height: 15),

                          // // Tarikh
                          // Row(
                          //   children: [
                          //     const Icon(
                          //       Icons.calendar_month,
                          //       color: Colors.black54,
                          //     ),
                          //     SizedBox(
                          //       width: 5.w,
                          //     ),
                          //     Text(
                          //       'Tarikh',
                          //       style: TextStyle(
                          //           fontSize: 18.sp,
                          //           fontWeight: FontWeight.bold,
                          //           color: Colors.black54),
                          //     ),
                          //     SizedBox(
                          //       width: 5.w,
                          //     ),
                          //   ],
                          // ),
                          const SizedBox(height: 5),

                          // //TextField Tarikh
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Expanded(
                          //       child: TextFormField(
                          //         enabled: false,
                          //         controller: startDateController,
                          //         autofocus: false,
                          //         cursorColor: Colors.white,
                          //         keyboardType: TextInputType.name,
                          //         autovalidateMode:
                          //         AutovalidateMode.onUserInteraction,
                          //         onSaved: (value) {
                          //           startDateController.text = value!;
                          //         },
                          //         textInputAction: TextInputAction.next,
                          //         decoration: InputDecoration(
                          //           contentPadding: const EdgeInsets.fromLTRB(
                          //               20, 15, 20, 15),
                          //           labelText:
                          //           '${start.year}/${start.month}/${start.day}',
                          //           border: OutlineInputBorder(
                          //               borderRadius:
                          //               BorderRadius.circular(10)),
                          //         ),
                          //       ),
                          //     ),
                          //     const SizedBox(
                          //       width: 12,
                          //     ),
                          //     Expanded(
                          //       child: TextFormField(
                          //         enabled: false,
                          //         controller: lastDateController,
                          //         autofocus: false,
                          //         cursorColor: Colors.white,
                          //         keyboardType: TextInputType.name,
                          //         autovalidateMode:
                          //         AutovalidateMode.onUserInteraction,
                          //         onSaved: (value) {
                          //           lastDateController.text = value!;
                          //         },
                          //         textInputAction: TextInputAction.next,
                          //         decoration: InputDecoration(
                          //           contentPadding: const EdgeInsets.fromLTRB(
                          //               20, 15, 20, 15),
                          //           labelText:
                          //           '${end.year}/${end.month}/${end.day}',
                          //           border: OutlineInputBorder(
                          //               borderRadius:
                          //               BorderRadius.circular(10)),
                          //         ),
                          //       ),
                          //     )
                          //   ],
                          // ),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Expanded(
                          //         child: ElevatedButton(
                          //           child: Text('Pilih Tarikh', style: TextStyle(color: Colors.black),),
                          //           onPressed: (){},
                          //           style: ElevatedButton.styleFrom(
                          //               primary: Colors.white70),
                          //         )),
                          //
                          //   ],
                          // ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [

                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: kZambeziColor),
                                  onPressed: () {
                                    addTanyaImam();
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.add,
                                        color: Colors.green,
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        "Tanya",
                                        style: TextStyle(fontSize: 16.sp),
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
                                      primary: kZambeziColor),
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
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        "Batal",
                                        style: TextStyle(fontSize: 16.sp),
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
  void addTanyaImam() async {
    EasyLoading.show(status: 'sedang diproses...');

    await fireStoreService.uploadTanyaData(titleController.text,
        descController.text);

    EasyLoading.showSuccess('Pertanyaan berjaya ditambah');
    Navigator.of(context).popAndPushNamed('/tanya');

    setState(() {});
  }
}
