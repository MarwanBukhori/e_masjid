import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_masjid/screens/petugas/program_detail_screen.dart';
import 'package:e_masjid/widgets/custom_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:e_masjid/screens/screens.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../config/constants.dart';
import '../widgets/custom_navbar.dart';

class ProgramScreen extends StatefulWidget {
  static const String routeName = '/program';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => ProgramScreen(),
    );
  }

  @override
  State<ProgramScreen> createState() => _ProgramScreenState();
}

class _ProgramScreenState extends State<ProgramScreen> {
  bool isDaily = false;
  bool visible = false;
  bool loading = true;
  String date = '';
  String formatDate = "";

  @override
  void initState() {
    super.initState();
    getData();
    checkUserRole();
  }

  List<Map<String, dynamic>> programs = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Floating action button sunting
      floatingActionButton: Visibility(
        visible: visible,
        child: FloatingActionButton.extended(
          heroTag: 'servis_hero',
          onPressed: () async {
            await Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddProgramScreen()));
          },
          label: const Text(" Program"),
          icon: const Icon(Icons.add),
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
                      'Jadual',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Program',
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
                    onPressed: () {},
                    icon: RotatedBox(
                      quarterTurns: 1,
                      child: Icon(
                        Icons.compare_arrows,
                        size: 28,
                      ),
                    ),
                    label: Text(
                      isDaily ? 'Harian' : 'Mingguan',
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
                    itemCount: programs.length,
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (c) => ProgramDetail(
                                        data: programs[index],
                                      )));
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
                                    programs[index]["title"],
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
                                      programs[index]["description"],
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ]),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  Row(children: [getDate(index)]),
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
      bottomNavigationBar: CustomNavBar(),
    );
  }

  //get data into list
  Future getData() async {
    await FirebaseFirestore.instance.collection("program").get().then((value) {
      for (var element in value.docs) {
        Map<String, dynamic> data = element.data();
        data.addAll({'id': element.id});
        programs.add(data);
      }
      programs.sort((a,b){
        var adate = a['firstDate'];
        var bdate = b['firstDate'];
        return adate.compareTo(bdate);
      });
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

  Widget getDate(int index) {
    // getData();
    date = programs[index]['firstDate'].toDate().toString();
    DateTime parsedDateTime = DateTime.parse(date);
    formatDate = DateFormat("dd-MM-yyyy").format(parsedDateTime);
    return Text(formatDate);
  }
}

