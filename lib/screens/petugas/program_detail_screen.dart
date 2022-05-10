import 'package:e_masjid/screens/petugas/edit_program.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../config/constants.dart';
import 'package:intl/intl.dart';

class ProgramDetail extends StatefulWidget {
  static const String routeName = '/program_detail';
  final Map<String, dynamic> data;

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => ProgramDetail(
        data: {},
      ),
    );
  }

  const ProgramDetail({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<ProgramDetail> createState() => _ProgramDetailState();
}

class _ProgramDetailState extends State<ProgramDetail> {
  bool visible = false;

  String formatDate = "";
  String formatDate2 = "";

  @override
  void initState() {
    super.initState();
    checkUserRole();
    convertTimestampToString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: visible,
        child: FloatingActionButton.extended(
          heroTag: 'sunting_hero',
          onPressed: () {
            setState(() {});
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProgram(id: widget.data["id"]),
                ));
          },
          label: const Text("Sunting"),
          icon: const Icon(Icons.edit),
          backgroundColor: kZambeziColor,
        ),
      ),
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    widget.data["title"],
                    style:
                        TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 25, right: 25, bottom: 25, top: 15),
              child: Container(
                height: 200.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.all(Radius.circular(15))),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    widget.data["description"],
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(25, 10, 1, 5),
              child: Row(children: [
                Text(
                  'Maklumat Program',
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                )
              ]),
            ),

            //content
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 15),
              child: Container(
                height: 300.h,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.all(Radius.circular(15))),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          // const Icon(Icons.calendar_month_rounded),
                          Text(
                            ' TARIKH :',
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(width: 11.w),
                          Row(
                            children: [
                              Text(
                                formatDate,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '  ->  ',
                                style: const TextStyle(fontSize: 15),
                              ),
                              Text(
                                formatDate2,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          // const Icon(Icons.calendar_month_rounded),
                          Text(
                            ' MASA :  ',
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),

                          Row(
                            children: [
                              Text(
                                formatDate,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '  ->  ',
                                style: const TextStyle(fontSize: 15),
                              ),
                              Text(
                                formatDate2,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  checkUserRole() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (value.data()!["role"].toString() == "petugas") {
        visible = true;
      } else {
        visible = false; 
      }

      setState(() {});
    });
  }

  convertTimestampToString() {
    //first date
    try {

      if (widget.data['firstDate'] is Timestamp) {
        Timestamp t = widget.data["firstDate"];
        String d = t.toDate().toString();
        DateTime parsedDateTime = DateTime.parse(d);
        formatDate = DateFormat("dd-MM-yyyy").format(parsedDateTime);

        //second date
        Timestamp t1 = widget.data["lastDate"];
        String d1 = t1.toDate().toString();
        DateTime parsedDateTime1 = DateTime.parse(d1);
        formatDate2 = DateFormat("dd-MM-yyyy").format(parsedDateTime1);
      } else {
        DateTime t = widget.data["firstDate"];
        String d = t.toString();
        DateTime parsedDateTime = DateTime.parse(d);
        formatDate = DateFormat("dd-MM-yyyy").format(parsedDateTime);

        //second date
        DateTime t1 = widget.data["lastDate"];
        String d1 = t1.toString();
        DateTime parsedDateTime1 = DateTime.parse(d1);
        formatDate2 = DateFormat("dd-MM-yyyy").format(parsedDateTime1);
      }
    } catch (e) {
      print(e);
    }
    setState(() {});
  }

}
