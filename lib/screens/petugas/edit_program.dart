import 'dart:developer';
import 'dart:io';

// import 'package:Jorania/screen/service.dart';
import 'package:e_masjid/services/firestore_service.dart';

// import 'package:Jorania/services/storage_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_masjid/screens/petugas/program_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:image_picker/image_picker.dart';

class EditProgram extends StatefulWidget {
  final String id;

  const EditProgram({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<EditProgram> createState() => _EditProgramState();
}

class _EditProgramState extends State<EditProgram> {
  // final ImagePicker imagePicker = ImagePicker();
  // List<dynamic>? imageNetworkList = [];
  // List<XFile>? imageFileList = [];
  // StorageServices storageServices = StorageServices();
  FireStoreService fireStoreService = FireStoreService();

  bool loading = true;
  late DocumentSnapshot<Map<String, dynamic>> data;

  final titleController = TextEditingController();
  final descController = TextEditingController();

  // final waktuController = TextEditingController();
  // final detailController = TextEditingController();
  // final operasiController = TextEditingController();
  // final telefonController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fireStoreService.getdataProgram(widget.id).then((value) {
      data = value;
      titleController.text = data["title"];
      descController.text = data["description"];
      // waktuController.text = data["ser_waktu"];
      // detailController.text = data["ser_desc"];
      // telefonController.text = data["ser_tel"];
      // imageNetworkList = data["ser_pic"];
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // var place = Provider.of<PlaceProvider>(context);
    // place.place = widget;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.grey,
        title: Text(
          'Kemaskini Program',
          style: TextStyle(
              fontSize: 26.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      body: loading
          ? Center(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  child: const CircularProgressIndicator()))
          : Column(children: [
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    margin: EdgeInsets.all(20.w),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(20.w),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 15,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.black,
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
                              //upload image
                              // imageNetworkList!.isNotEmpty
                              //     ? SizedBox(
                              //   width: double.infinity,
                              //   height: 200.h,
                              //   child: ListView.separated(
                              //     itemCount: imageNetworkList!.length,
                              //     scrollDirection: Axis.horizontal,
                              //     itemBuilder: (context, index) {
                              //       log(index.toString());
                              //       return Stack(
                              //         clipBehavior: Clip.none,
                              //         children: [
                              //           Image.network(
                              //             imageNetworkList![index],
                              //             fit: BoxFit.cover,
                              //           ),
                              //           Positioned(
                              //             top: 0,
                              //             right: 0,
                              //             child: GestureDetector(
                              //               onTap: () {
                              //                 imageNetworkList!
                              //                     .removeAt(index);
                              //                 setState(() {});
                              //               },
                              //               child: Container(
                              //                 padding:
                              //                 const EdgeInsets.all(5),
                              //                 decoration:
                              //                 const BoxDecoration(
                              //                     shape:
                              //                     BoxShape.circle,
                              //                     color: Colors.red),
                              //                 child: const Icon(
                              //                   Icons.delete,
                              //                   color: Colors.white,
                              //                 ),
                              //               ),
                              //             ),
                              //           ),
                              //         ],
                              //       );
                              //     },
                              //     separatorBuilder:
                              //         (BuildContext context, int index) {
                              //       return const SizedBox(
                              //         width: 10,
                              //       );
                              //     },
                              //   ),
                              // )
                              //     : const SizedBox(),
                              // SizedBox(
                              //   height: 10.h,
                                // ),
                                // imageFileList!.isEmpty
                                //     ? ElevatedButton(
                                //     style: ElevatedButton.styleFrom(
                                //         minimumSize:
                                //         const Size(double.infinity, 40),
                                //         primary: Colors.orange),
                                //     onPressed: () {
                                //       selectImages();
                                //     },
                                //     child: Row(
                                //         mainAxisAlignment:
                                //         MainAxisAlignment.center,
                                //         children: const [
                                //           Text("MUAT NAIK GAMBAR"),
                                //           SizedBox(
                                //             width: 30,
                                //           ),
                                //           Icon(Icons.add_photo_alternate)
                                //         ]))
                                //     : SizedBox(
                                //   height: 200.h,
                                //   child: ListView.builder(
                                //       scrollDirection: Axis.horizontal,
                                //       itemCount: imageFileList!.length,
                                //       itemBuilder: ((context, index) {
                                //         return Stack(
                                //           children: [
                                //             Image.file(
                                //               File(imageFileList![index]
                                //                   .path),
                                //               fit: BoxFit.cover,
                                //             ),
                                //             Positioned(
                                //               top: 0,
                                //               right: 0,
                                //               child: GestureDetector(
                                //                 onTap: () {
                                //                   imageFileList!
                                //                       .removeAt(index);
                                //                   setState(() {});
                                //                 },
                                //                 child: Container(
                                //                   padding:
                                //                   const EdgeInsets.all(
                                //                       5),
                                //                   decoration:
                                //                   const BoxDecoration(
                                //                       shape: BoxShape
                                //                           .circle,
                                //                       color:
                                //                       Colors.red),
                                //                   child: const Icon(
                                //                     Icons.delete,
                                //                     color: Colors.white,
                                //                   ),
                                //                 ),
                                //               ),
                                //             )
                                //           ],
                                //         );
                                //       })),
                              // ),
                              SizedBox(
                                height: 10.h,
                              ),

                              //title
                              Row(
                                children: [
                                  Text(
                                    'Title',
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  const Icon(
                                    Icons.store,
                                    color: Colors.black54,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 3),
                              TextFormField(
                                controller: titleController,
                                autofocus: false,
                                cursorColor: Colors.white,
                                keyboardType: TextInputType.name,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  RegExp regex = RegExp(r'^.{5,}$');
                                  if (value!.isEmpty) {
                                    return ("Sila isi butiran nama program");
                                  }
                                  if (!regex.hasMatch(value)) {
                                    return ("masukkan minimum 5 huruf");
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
                                  labelText: '',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                              const SizedBox(height: 15),

                              //description
                              Row(
                                children: [
                                  Text(
                                    'Description',
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  const Icon(
                                    Icons.calendar_month_rounded,
                                    color: Colors.black54,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    '(cth Gotong Royong...)',
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  )
                                ],
                              ),
                              const SizedBox(height: 3),
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
                                    return ("Sila isi butiran description");
                                  }
                                  if (!regex.hasMatch(value)) {
                                    return ("masukkan minimum 5 huruf");
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
                                  labelText: '',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                              const SizedBox(height: 15),


                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.black),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Batal ",
                                            style: TextStyle(fontSize: 16.sp),
                                          ),
                                          const Icon(
                                            Icons.cancel_outlined,
                                            color: Colors.red,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.black),
                                      onPressed: () {
                                        EasyLoading.show(
                                            status: 'Sedang diproses');

                                          fireStoreService
                                              .updateServiceData(
                                            titleController.text,
                                            descController.text,
                                            // waktuController.text,
                                            // telefonController.text,
                                            // detailController.text,
                                            widget.id,
                                          )
                                              // imageNetworkList)
                                              .then((value) {
                                            EasyLoading.showSuccess(
                                                "Kemaskini Info Program Berjaya");
                                            Map<String, dynamic> a =
                                                data.data()!;
                                            a.addAll({'id': widget.id});
                                            // a.update('ser_pic',
                                            //         (value) => imageNetworkList);
                                            a.update(
                                                'title',
                                                (value) =>
                                                    titleController.text);
                                            a.update('description',
                                                (value) => descController.text);
                                            Navigator.pop(context);

                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProgramDetail(
                                                            data: a)));
                                          });

                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Simpan",
                                            style: TextStyle(fontSize: 16.sp),
                                          ),
                                          const Icon(
                                            Icons.save,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      // set up the buttons
                                      Widget cancelButton = TextButton(
                                        child: const Text("Tidak"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      );
                                      Widget continueButton = TextButton(
                                        child: const Text("Ya"),
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection("program")
                                              .doc(widget.id)
                                              .delete();
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                          // Navigator.of(context).pop();
                                          Navigator.of(context).popAndPushNamed('/petugas_program');
                                        },
                                      );

                                      // set up the AlertDialog
                                      AlertDialog alert = AlertDialog(
                                        title: const Text("Buang Servis"),
                                        content: const Text(
                                            "Anda pasti mahu buang servis?"),
                                        actions: [
                                          continueButton,
                                          cancelButton,
                                        ],
                                      );

                                      // show the dialog
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return alert;
                                        },
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
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
              )
            ]),
    );
  }
//
// Future uploadImage() async {
//   for (int i = 0; i <= imageFileList!.length; i++) {
//     if (i == imageFileList!.length) {
//       return;
//     }
//     String url = await storageServices.uploadFile(
//         "service/${imageFileList![i].name}", File(imageFileList![i].path));
//     imageNetworkList!.add(url);
//   }
// }

// void selectImages() async {
//   final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
//   if (selectedImages!.isNotEmpty) {
//     imageFileList = [];
//     imageFileList!.addAll(selectedImages);
//   }
//   print("Image List Length:" + imageFileList!.length.toString());
//   setState(() {});
// }
}
