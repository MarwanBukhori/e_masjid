import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_masjid/screens/semak_detail_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../config/constants.dart';
import '../providers/user.provider.dart';
import '../widgets/custom_navbar.dart';

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
  bool notvisible = false;
  String date = '';
  String? _selectedView = "Tanya Imam";
  List<String> _type = ['Tanya Imam', 'Nikah', 'Qurban'];

  @override
  void initState() {
    super.initState();
    getTanyaData();
    getNikahData();
    getQurbanData();
    checkUserRole();
  }

  List<Map<String, dynamic>> mainList = [];
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 40.0, top: 20, right: 20, bottom: 10),
                  child: DropdownButtonFormField<String>(
                    hint: Text(_selectedView!),
                    items: _type.map((view) {
                      return DropdownMenuItem<String>(
                        value: view,
                        child: Text(view),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      mainList.clear();
                      if (newValue == "Nikah") {
                        setState(() {
                          _selectedView = newValue;
                          mainList.addAll(nikahList);
                        });
                      } else if (newValue == "Qurban") {
                        setState(() {
                          _selectedView = newValue;
                          mainList.addAll(qurbanList);
                        });
                      } else {
                        setState(() {
                          _selectedView = newValue;
                          mainList.addAll(pertanyaanList);
                        });
                      }
                    },
                  ),
                ),
              )
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
                    itemCount: mainList.length,
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (c) => SemakDetail(
                                        data: mainList[index],
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
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                         Text(
                                          mainList[index]["title"],
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),

                                        mainList[index]["isApproved"]
                                            ?  Padding(
                                              padding: const EdgeInsets.only(right: 20.0),
                                              child: Icon(
                                                  Icons.check,
                                                  color: Colors.green,
                                                ),
                                            )
                                            : Padding(
                                              padding: const EdgeInsets.only(right: 20.0),
                                              child: Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                ),
                                            )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    Row(children: [
                                      // const Icon(Icons.calendar_month_rounded),
                                      Flexible(
                                        child: Text(
                                          mainList[index]["description"],
                                          style: const TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ]),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    // Row(children: [getDate(index)]),
                                  ],
                                ),
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
      bottomNavigationBar: Visibility(
          visible: notvisible,
          child: CustomNavBar()),
    );
  }

  //get data into list
  Future getTanyaData() async {
    await FirebaseFirestore.instance.collection("tanya").where("authorId", isEqualTo: AppUser().user!.uid ).get().then((value) {
      for (var element in value.docs) {
        Map<String, dynamic> data = element.data();
        data.addAll({'id': element.id});
        pertanyaanList.add(data);
      }
      mainList.addAll(pertanyaanList);

      print(pertanyaanList);
      if (mounted) {
        loading = false;
        setState(() {});
      }
    });
  }

  //get data into list
  Future getNikahData() async {
    await FirebaseFirestore.instance.collection("nikah").where("authorId", isEqualTo: AppUser().user!.uid ).get().then((value) {
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

  //get qurban data into list
  Future getQurbanData() async {
    await FirebaseFirestore.instance.collection("qurban").where("authorId", isEqualTo: AppUser().user!.uid ).get().then((value) {
      for (var element in value.docs) {
        Map<String, dynamic> data = element.data();
        data.addAll({'id': element.id});
        qurbanList.add(data);
      }

      print(qurbanList);
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
        notvisible = true;
      }
      setState(() {});
    });
  }
}
