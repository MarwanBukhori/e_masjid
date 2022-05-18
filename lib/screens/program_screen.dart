import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_masjid/screens/petugas/program_detail_screen.dart';
import 'package:e_masjid/widgets/custom_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:e_masjid/screens/screens.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
// import 'package:e_masjid/screens/petugas/add_program_screen.dart';
import '../config/constants.dart';
import 'package:e_masjid/screens/petugas/add_program_screen.dart';
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
  String date2 = '';
  String masaMula = '';
  String masaTamat = '';
  String formatDate = "";
  String formatDate2 = "";
  String? _selectedView = "Semua";
  List<String> _type = ['Harian', 'Mingguan', 'Bulanan', 'Semua'];

  @override
  void initState() {
    super.initState();
    getData();
    calculateDaily();
    checkUserRole();
  }

  List<Map<String, dynamic>> programs = [];
  List<Map<String, dynamic>> dailyList = [];
  List<Map<String, dynamic>> weeklyList = [];
  List<Map<String, dynamic>> monthlyList = [];

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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 40.0, top: 20, right: 20, bottom: 10),
                  child: DropdownButtonFormField<String>(
                    hint: Text(_selectedView!),
                    items: _type.map((view) {
                      return DropdownMenuItem<String>(
                        value: view,
                        child: Text(view),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      if (newValue == "Harian"){
                        setState(() {
                          _selectedView = newValue;
                          programs.clear();
                          programs.addAll(dailyList);

                        });

                      } else if (newValue == "Mingguan"){
                        setState(() {
                          _selectedView = newValue;
                          // mainList.addAll(qurbanList);

                        });

                      }
                      else if (newValue == "Semua"){
                        programs.clear();
                        setState(() {
                          _selectedView = newValue;
                          getData();

                        });

                      }else {
                        setState(() {
                          _selectedView = newValue;
                          // mainList.addAll(pertanyaanList);

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
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Row(children: [getTime(index)]),
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

    date2 = programs[index]['lastDate'].toDate().toString();
    DateTime parsedDateTime2 = DateTime.parse(date2);
    formatDate2 = DateFormat("dd-MM-yyyy").format(parsedDateTime2);

    return Text("Tarikh : ${formatDate}  -  ${formatDate2}");
  }

  Widget getTime(int index){
    masaMula = programs[index]['masa'];
    masaTamat = programs[index]['masaTamat'];
    return Text("Masa : ${masaMula}  -  ${masaTamat}");
  }

   calculateDaily() {
     DateTime now = DateTime.now();
     final day = DateTime.now().day;
     final today = DateTime(now.year, now.month, now.day,);

     for (var day in programs) {

       if(day == today){
         dailyList.add(day);
       }
     }

     if (mounted) {
       loading = false;
       setState(() {});
     }
   }

  calculateWeekly() {
    final month = DateTime.now().month;
    final day = DateTime.now().day;
    final year = DateTime.now().year;
    final days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
  }

  calculateMonthly() {
    final month = DateTime.now().month;
    final day = DateTime.now().day;
    final year = DateTime.now().year;
    final days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
  }

}

