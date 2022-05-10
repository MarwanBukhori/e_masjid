import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../config/constants.dart';
import '../models/temujanji_model.dart';
import '../services/temujanji.service.dart';

class SemakStatusScreen extends StatefulWidget {
  static const String routeName = '/semak';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => SemakStatusScreen(),
    );
  }

  @override
  State<SemakStatusScreen> createState() => _SemakStatusScreenState();
}

class _SemakStatusScreenState extends State<SemakStatusScreen> {
  bool loading = true;
  bool visible = false;
  bool isTanya = true;
  bool isNikah = false;
  String date = '';

  @override
  void initState() {
    super.initState();
    getTanyaData();
    checkUserRole();
  }

  List<Map<String, dynamic>> pertanyaanList = [];
  List<Map<String, dynamic>> nikahList = [];
  List<Map<String, dynamic>> qurbanList = [];

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

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Semak',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Status',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60),
                child: TextButton.icon(
                    onPressed: () {

                    },
                    icon: RotatedBox(
                      quarterTurns: 1,
                      child: Icon(
                        Icons.compare_arrows,
                        size: 28,
                      ),
                    ),
                    label: Text(
                      isTanya ? 'Tanya' : 'Nikah',
                      style: TextStyle(fontSize: 16),
                    )),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Expanded(
            child: loading
                ? const SizedBox(
                width: double.infinity,
                child: Center(child: CircularProgressIndicator()))
                : ListView.builder(
              key: UniqueKey(),
              physics: const BouncingScrollPhysics(),
              itemCount: pertanyaanList.length,
              itemBuilder: ((context, index) {
                return GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (c) => ProgramDetail(
                    //           data: programs[index],
                    //         )));
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                    height: 110,
                    decoration: const BoxDecoration(
                        color: kDarkGreyColor,
                        borderRadius:
                        BorderRadius.all(Radius.circular(20))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 35.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              pertanyaanList[index]["title"],
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Row(children: [
                              // const Icon(Icons.calendar_month_rounded),
                              Text(
                                pertanyaanList[index]["description"],
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ]),
                            SizedBox(
                              height: 15.h,
                            ),
                            // Row(children: [getDate(index)]),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }


  //get data into list
  Future getTanyaData() async {
    await FirebaseFirestore.instance.collection("tanya").get().then((value) {
      for (var element in value.docs) {
        Map<String, dynamic> data = element.data();
        data.addAll({'id': element.id});
        pertanyaanList.add(data);
      }
      // pertanyaan.sort((a,b){
      //   var adate = a['firstDate'];
      //   var bdate = b['firstDate'];
      //   return adate.compareTo(bdate);
      // });
      print(pertanyaanList);
      if (mounted) {
        loading = false;
        setState(() {});
      }
    });
  }

  //get data into list
  Future getNikahData() async {
    await FirebaseFirestore.instance.collection("nikah").get().then((value) {
      for (var element in value.docs) {
        Map<String, dynamic> data = element.data();
        data.addAll({'id': element.id});
        nikahList.add(data);
      }

      print(nikahList);
      if (mounted) {
        loading = false;
        setState(() {});
      }
    });
  }

  //check user role
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

}


