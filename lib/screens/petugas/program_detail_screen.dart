// import 'package:Jorania/providers/place_provider.dart';
import 'package:e_masjid/screens/petugas/edit_program.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_masjid/screens/petugas/edit_program.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/constants.dart';

class ProgramDetail extends StatefulWidget {
  final Map<String, dynamic> data;

  const ProgramDetail({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<ProgramDetail> createState() => _ProgramDetailState();
}

class _ProgramDetailState extends State<ProgramDetail> {
  bool visible = false;
  List<dynamic>? picUrl;
  bool liked = false;

  @override
  void initState() {
    super.initState();
    checkUserRole();
    // picUrl = widget.data["ser_pic"];
  }

  @override
  Widget build(BuildContext context) {
    // var place = Provider.of<PlaceProvider>(context);
    // place.place = widget;

    return Scaffold(
      floatingActionButton: Visibility(
        visible: visible,
        child: FloatingActionButton.extended(
          heroTag: 'sunting_hero',
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditProgram(id: widget.data["id"])));
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
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25, top: 15),
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
                            const Icon(Icons.calendar_month_rounded),
                            SizedBox(width: 11.w),
                            Text(
                              widget.data["title"],
                              style: const TextStyle(
                                fontSize: 15
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          children: [
                            const Icon(Icons.alarm),
                            SizedBox(width: 11.w),
                            Text(
                              widget.data["description"],
                              style: const TextStyle(
                                  fontSize: 15
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        // Row(
                        //   children: [
                        //     const Icon(Icons.phone),
                        //     SizedBox(width: 5.w),
                        //     Text(
                        //       widget.data["ser_tel"],
                        //       style: const TextStyle(),
                        //     ),
                        //   ],
                        // ),
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

  void _launchUrl() async {
    if (!await launch(
        "https://wa.me/+6'${widget.data["ser_tel"]}'?text=Jorania%3E%20adakah%20servis%20masih%20tersedia%3F%0A")) {
      throw 'Could not launch ';
    }
  }
}
