import 'dart:developer';
import 'dart:io';

// import 'package:Jorania/providers/place_provider.dart';
import 'package:e_masjid/services/firestore_service.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../services/firestore_service.dart';

class AddProgramScreen extends StatefulWidget {
  const AddProgramScreen({Key? key}) : super(key: key);

  @override
  State<AddProgramScreen> createState() => _AddProgramScreenState();
}

class _AddProgramScreenState extends State<AddProgramScreen> {
  // final ImagePicker imagePicker = ImagePicker();
  // List<XFile>? imageFileList = [];
  // StorageServices storageServices = StorageServices();
  FireStoreService fireStoreService = FireStoreService();

  final titleController = TextEditingController();
  final descController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    // var place = Provider.of<PlaceProvider>(context);
    // place.place = widget;
    return Scaffold(
      body: Column(children: [
        const SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.store),
            Text(
              'Tambah Program',
              style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
            ),
          ],
        ),
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
                border: Border.all(color: Colors.orange, width: 2),
                borderRadius: BorderRadius.circular(20.w),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 15,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.orange,
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
                        // //upload image
                        // imageFileList!.isNotEmpty
                        //     ? SizedBox(
                        //   width: double.infinity,
                        //   height: 200,
                        //   child: ListView.separated(
                        //     itemCount: imageFileList!.length,
                        //     scrollDirection: Axis.horizontal,
                        //     itemBuilder: (context, index) {
                        //       log(index.toString());
                        //       return Stack(
                        //         clipBehavior: Clip.none,
                        //         children: [
                        //           Image.file(
                        //             File(imageFileList![index].path),
                        //             fit: BoxFit.cover,
                        //           ),
                        //           Positioned(
                        //             top: 0,
                        //             right: 0,
                        //             child: GestureDetector(
                        //               onTap: () {
                        //                 imageFileList!.removeAt(index);
                        //                 setState(() {});
                        //               },
                        //               child: Container(
                        //                 padding: const EdgeInsets.all(5),
                        //                 decoration: const BoxDecoration(
                        //                     shape: BoxShape.circle,
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
                        // ElevatedButton(
                        //     style: ElevatedButton.styleFrom(
                        //         minimumSize: const Size(double.infinity, 40),
                        //         primary: Colors.orange),
                        //     onPressed: () {
                        //       selectImages();
                        //     },
                        //     child: Row(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: const [
                        //           Text("MUAT NAIK GAMBAR"),
                        //           SizedBox(
                        //             width: 30,
                        //           ),
                        //           Icon(Icons.add_photo_alternate)
                        //         ])),
                        const SizedBox(
                          height: 20,
                        ),

                        // Title
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            RegExp regex = RegExp(r'^.{5,}$');
                            if (value!.isEmpty) {
                              return ("Sila isi butiran nama servis");
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

                        // Description
                        Row(
                          children: [
                            Text(
                              'Desc',
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
                              'Gotong royong..',
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            RegExp regex = RegExp(r'^.{5,}$');
                            if (value!.isEmpty) {
                              return ("Sila isi butiran hari operasi");
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
                            labelText: '',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        const SizedBox(height: 15),

                        const SizedBox(height: 10),

                        const SizedBox(height: 10),

                        //TIPS

                        SizedBox(height: 10.h),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.orange),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Batal",
                                      style: TextStyle(fontSize: 16.sp),
                                    ),
                                    SizedBox(
                                      width: 20.w,
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
                                    primary: Colors.orange),
                                onPressed: () {

                                  AddService();

                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Tambah",
                                      style: TextStyle(fontSize: 16.sp),
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    const Icon(
                                      Icons.add_circle_outline,
                                      color: Colors.green,
                                    )
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
        )
      ]),
    );
  }

  void AddService() async {
    EasyLoading.show(status: 'sedang diproses...');

    // List<String> picUrl = await uploadImage();

    await fireStoreService.uploadServiceData(
        titleController.text,
        descController.text);

    EasyLoading.showSuccess('Program berjaya ditambah!');
    Navigator.of(context).popAndPushNamed('/petugas_program');

    setState(() {});
  }

  // Future uploadImage() async {
  //   List<String> picUrl = [];
  //   for (int i = 0; i <= imageFileList!.length; i++) {
  //     if (i == imageFileList!.length) {
  //       return picUrl;
  //     }
  //     String url = await storageServices.uploadFile(
  //         "service/${imageFileList![i].name}", File(imageFileList![i].path));
  //     picUrl.add(url);
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
