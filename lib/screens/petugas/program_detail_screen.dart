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
    // checkUserRole();
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
          label: const Text("kemaskini"),
          icon: const Icon(Icons.edit),
          backgroundColor: Colors.orange,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.orange[300],
        title: const Text('Servis '),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            // Container(
            //   margin: EdgeInsets.all(20.w),
            //   // color: Color.fromARGB(255, 163, 130, 130),
            //   child: CarouselSlider(
            //     options: CarouselOptions(height: 255.0),
            //     items: picUrl!.map((i) {
            //       return Builder(
            //         builder: (BuildContext context) {
            //           return Image.network(
            //             i,
            //             fit: BoxFit.cover,
            //           );
            //         },
            //       );
            //     }).toList(),
            //   ),
            // ),

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
              padding: const EdgeInsets.all(16),
              child: Container(
                height: 300.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.all(Radius.circular(15))),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    widget.data["description"],
                    style: const TextStyle(),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 1, 1, 1),
              child: Row(children: [
                Text(
                  'Info servis',
                  style:
                  TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                )
              ]),
            ),

            //content keterangan
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                height: 160.h,
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
                          SizedBox(width: 5.w),
                          Text(
                            widget.data["title"],
                            style: const TextStyle(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.alarm),
                          SizedBox(width: 5.w),
                          Text(
                            widget.data["description"],
                            style: const TextStyle(),
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

            //header tips

            //content tips

            SizedBox(height: 20.h),
            //button GPS
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(50, 50),
                        primary: Colors.deepOrange[300],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13))),
                    onPressed: () {
                      _launchUrl();
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.whatsapp,
                          color: Colors.green[400],
                          size: 35,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Whatsapp',
                          style: TextStyle(fontSize: 25.sp),
                        ),
                        SizedBox(
                          width: 10.w,
                        )
                      ],
                    )),
              ],
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }

  // checkUserRole() {
  //   FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get()
  //       .then((value) {
  //     if (value.data()!["role"].toString() == "petugas") {
  //       visible = true;
  //     } else {
  //       visible = false;
  //     }
  //     setState(() {});
  //   });
  // }

  void _launchUrl() async {
    if (!await launch(
        "https://wa.me/+6'${widget.data["ser_tel"]}'?text=Jorania%3E%20adakah%20servis%20masih%20tersedia%3F%0A")) {
      throw 'Could not launch ';
    }
  }
}
