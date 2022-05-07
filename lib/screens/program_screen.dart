import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_masjid/screens/petugas/program_detail_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:e_masjid/screens/screens.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  bool visible = false;
  bool loading = true;

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
          backgroundColor: const Color.fromARGB(255, 150, 100, 55),
        ),
      ),

      //appbar
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Senarai Program'),
              Icon(
                Icons.store,
                size: 30.sp,
              ),
              //icon button tambah servis
            ],
          ),
          actions: [
            //search button
            IconButton(
                onPressed: () {
                  // showSearch(
                  //   context: context,
                  //   delegate: MySearchDelegate(services: services),
                  // );
                },
                icon: const Icon(
                  Icons.search,
                  size: 35,
                ))
          ]),
      body: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          //List View
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
                          margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                          height: 100,
                          decoration: const BoxDecoration(
                              color: Colors.grey,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 50.w,
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
                                  Row(children: [
                                    const Icon(Icons.calendar_month_rounded),
                                    Text(
                                      programs[index]["description"],
                                    ),
                                  ]),
                                  // Row(children: [
                                  //   const Icon(Icons.access_alarm),
                                  //   Text(
                                  //     programs[index]["ser_waktu"],
                                  //   ),
                                  // ]),
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
  Future getData() async {
    await FirebaseFirestore.instance.collection("program").get().then((value) {
      for (var element in value.docs) {
        Map<String, dynamic> data = element.data();
        data.addAll({'id': element.id});
        programs.add(data);
      }
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

//search function
//
// class MySearchDelegate extends SearchDelegate {
//   List programs;
//
//   MySearchDelegate({
//     required this.programs,
//   });
//
//   @override
//   //
//   String? get searchFieldLabel => "Cari program";
//
//   @override
//   Widget? buildLeading(BuildContext context) => IconButton(
//         icon: const Icon(Icons.arrow_back_ios),
//         onPressed: () => close(context, null),
//       );
//
//   @override
//   List<Widget>? buildActions(BuildContext context) => [
//         IconButton(
//           icon: const Icon(Icons.clear),
//           onPressed: () {
//             if (query.isEmpty) {
//               close(context, null); //close search bar
//             } else {
//               query = '';
//             }
//           },
//         ),
//       ];
//
//   @override
//   Widget buildResults(BuildContext context) {
//     List data = [];
//
//     for (int i = 0; i < programs.length; i++) {
//       if ((programs[i]["title"] as String).toLowerCase() ==
//           query.toLowerCase()) {
//         data.add(programs[i]);
//       }
//     }
//
//     return ListView.builder(
//       itemCount: data.length,
//       itemBuilder: (context, index) {
//         return GestureDetector(
//           onTap: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (c) => ProgramDetail(
//                           data: data[index],
//                         )));
//           },
//           child: Container(
//             margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
//             height: 100,
//             decoration: const BoxDecoration(
//                 color: Color.fromARGB(255, 216, 192, 161),
//                 borderRadius: BorderRadius.all(Radius.circular(20))),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   width: 50.w,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Text(
//                       data[index]["title"],
//                       style: const TextStyle(
//                           fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     Row(children: [
//                       const Icon(Icons.calendar_month_rounded),
//                       Text(
//                         data[index]["description"],
//                       ),
//                     ]),
//                     // Row(children: [
//                     //   const Icon(Icons.access_alarm),
//                     //   Text(
//                     //     data[index]["ser_waktu"],
//                     //   ),
//                     // ]),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     List data = [];
//
//     for (int i = 0; i < programs.length; i++) {
//       if ((programs[i]["title"] as String)
//           .toLowerCase()
//           .contains(query.toLowerCase())) {
//         data.add(programs[i]);
//       }
//     }
//
//     return ListView.builder(
//       itemCount: data.length,
//       itemBuilder: (context, index) {
//         return GestureDetector(
//           onTap: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (c) => ProgramDetail(
//                           data: data[index],
//                         )));
//           },
//           child: Container(
//             margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
//             height: 100,
//             decoration: const BoxDecoration(
//                 color: Color.fromARGB(255, 216, 192, 161),
//                 borderRadius: BorderRadius.all(Radius.circular(20))),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   width: 50.w,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Text(
//                       data[index]["title"],
//                       style: const TextStyle(
//                           fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     Row(children: [
//                       const Icon(Icons.calendar_month_rounded),
//                       Text(
//                         data[index]["description"],
//                       ),
//                     ]),
//                     // Row(children: [
//                     //   const Icon(Icons.access_alarm),
//                     //   Text(
//                     //     data[index]["ser_waktu"],
//                     //   ),
//                     // ]),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
