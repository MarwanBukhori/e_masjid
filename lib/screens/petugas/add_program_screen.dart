import 'package:e_masjid/services/firestore_service.dart';
import 'package:e_masjid/widgets/custom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/constants.dart';
import '../../services/firestore_service.dart';

class AddProgramScreen extends StatefulWidget {
  const AddProgramScreen({Key? key}) : super(key: key);

  @override
  State<AddProgramScreen> createState() => _AddProgramScreenState();
}

class _AddProgramScreenState extends State<AddProgramScreen> {
  FireStoreService fireStoreService = FireStoreService();
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  TimeOfDay time2 = TimeOfDay.now();
  String timeString = '';
  String timeString2 = '';

  bool pickedDate = false;
  bool pickedTime = false;
  bool pickedTime2 = false;

  DateTimeRange dateRange =
  DateTimeRange(start: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day), end: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));

  final titleController = TextEditingController();
  final descController = TextEditingController();
  final startDateController = TextEditingController();
  final lastDateController = TextEditingController();

  String getMasaMula() {
    if (pickedTime != true) {
      return 'Pilih Masa Mula';
    } else {

      final hours = time.hour.toString().padLeft(2, '0');
      final minutes = time.minute.toString().padLeft(2, '0');
      return '$hours:$minutes';


    }
  }

  String getMasaTamat() {
    if (pickedTime2 != true) {
      return 'Pilih Masa Tamat';
    } else {
      final hours2 = time2.hour.toString().padLeft(2, '0');
      final minutes2 = time2.minute.toString().padLeft(2, '0');
      return '$hours2:$minutes2';
    }
  }

  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;

    return Scaffold(
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
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            'Tambah',
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
        SizedBox(
          height: 10.h,
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                margin: EdgeInsets.all(20.w),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: kPrimaryColor, width: 1),
                  borderRadius: BorderRadius.circular(20.w),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 0, top: 5, right: 8, bottom: 5),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.lightbulb_rounded,
                                  color: Colors.yellow,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  'Tajuk',
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: titleController,
                            autofocus: false,
                            cursorColor: kZambeziColor,
                            keyboardType: TextInputType.name,
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              RegExp regex = RegExp(r'^.{5,}$');
                              if (value!.isEmpty) {
                                return ("Sila isi tajuk program");
                              }
                              if (!regex.hasMatch(value)) {
                                return ("masukkan minimum 5 aksara");
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
                              labelText: 'Nama',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          const SizedBox(height: 15),

                          // Description
                          Row(
                            children: [
                              const Icon(
                                Icons.edit_note_outlined,
                                color: Colors.teal,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                'Huraian',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),

                            ],
                          ),
                          const SizedBox(height: 10),

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
                                return ("Sila isi huraian program");
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
                              labelText: 'Cth : Gotong Royong anjuran Masjid..',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          const SizedBox(height: 15),

                          // Tarikh
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month,
                                color: Colors.orange,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                'Tarikh',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          //TextField Tarikh
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  enabled: false,
                                  controller: startDateController,
                                  autofocus: false,
                                  cursorColor: Colors.white,
                                  keyboardType: TextInputType.name,
                                  autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                                  onSaved: (value) {
                                    startDateController.text = value!;
                                  },
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        20, 15, 20, 15),
                                    labelText:
                                    '${start.year}/${start.month}/${start.day}',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: TextFormField(
                                  enabled: false,
                                  controller: lastDateController,
                                  autofocus: false,
                                  cursorColor: Colors.white,
                                  keyboardType: TextInputType.name,
                                  autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                                  onSaved: (value) {
                                    lastDateController.text = value!;
                                  },
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        20, 15, 20, 15),
                                    labelText:
                                    '${end.year}/${end.month}/${end.day}',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: ElevatedButton(
                                    child: Text('Pilih Tarikh', style: TextStyle(color: Colors.black),),
                                    onPressed: pickDateRange,
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.white70),
                                  )),

                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),


                          // Masa mula
                          Row(
                            children: [
                              const Icon(
                                Icons.query_builder_rounded,
                                color: Colors.pink,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                'Masa Mula',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 5,
                          ),

                          //button masa mula
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  child: Text(
                                    getMasaMula(),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onPressed: () {
                                    pickTimeMula(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.white70),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),

                          // Masa Tamat
                          Row(
                            children: [
                              const Icon(
                                Icons.query_builder_rounded,
                                color: Colors.lightGreen,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                'Masa Tamat',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 5,
                          ),

                          //button masa tamat
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  child: Text(
                                    getMasaTamat(),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onPressed: () {
                                    pickTimeTamat(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.white70),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [

                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: kPrimaryColor),
                                  onPressed: () {
                                    AddProgram();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.add,
                                        color: Colors.green,
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: kPrimaryColor),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.cancel,
                                        color: Colors.red,
                                      ),



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
          ),
        )
      ]),
      // bottomNavigationBar: CustomNavBar(),
    );
  }

  void AddProgram() async {
    EasyLoading.show(status: 'sedang diproses...');

    await fireStoreService.uploadProgramData(titleController.text,
        descController.text, dateRange.start, dateRange.end, timeString, timeString2);

    EasyLoading.showSuccess('Program berjaya ditambah');
    Navigator.of(context).popAndPushNamed('/program');

    setState(() {});
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    //press cancel x
    if (newDateRange == null) return;

    setState(() => dateRange = newDateRange);
  }

  Future pickTimeMula(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
        context: context, initialTime: time ?? initialTime);

    if (newTime == null) return;

    pickedTime = true;

    setState(() => time = newTime);
    timeString = time.format(context);
  }

  Future pickTimeTamat(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime2 = await showTimePicker(
        context: context, initialTime: time2 ?? initialTime);

    if (newTime2 == null) return;

    pickedTime2 = true;

    setState(() => time2 = newTime2);
    timeString2 = time2.format(context);
  }
}