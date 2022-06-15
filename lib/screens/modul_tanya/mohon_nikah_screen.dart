import 'package:e_masjid/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:e_masjid/widgets/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../services/firestore_service.dart';

class MohonNikahScreen extends StatefulWidget {
  const MohonNikahScreen({Key? key}) : super(key: key);
  static const String routeName = '/nikah';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => MohonNikahScreen(),
    );
  }

  @override
  _MohonNikahScreenState createState() => _MohonNikahScreenState();
}

class _MohonNikahScreenState extends State<MohonNikahScreen> {
  FireStoreService fireStoreService = FireStoreService();
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  String timeString = '';

  bool pickedDate = false;
  bool pickedTime = false;

  final pemohonController = TextEditingController();
  final pasanganController = TextEditingController();

  String getTarikh() {
    if (pickedDate != true) {
      return 'Pilih Tarikh';
    } else {
      return '${date.month}/${date.day}/${date.year}';
    }
  }

  String getMasa() {
    if (pickedTime != true) {
      return 'Pilih Masa';
    } else {
      final hours = time.hour.toString().padLeft(2, '0');
      final minutes = time.minute.toString().padLeft(2, '0');
      return '$hours:$minutes';
    }
  }

  @override
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
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            'Mohon',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 25.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            'Nikah',
            style: TextStyle(
                color: Colors.black87,
                fontSize: 35.0,
                fontWeight: FontWeight.bold),
          ),
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
                  border: Border.all(color: kZambeziColor, width: 1),
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
                                  Icons.person,
                                  color: Colors.lightBlue,
                                ),
                                SizedBox(
                                  width: 9.w,
                                ),
                                Text(
                                  'Pemohon',
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            controller: pemohonController,
                            autofocus: false,
                            cursorColor: kZambeziColor,
                            keyboardType: TextInputType.name,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              RegExp regex = RegExp(r'^.{5,}$');
                              if (value!.isEmpty) {
                                return ("Sila isi nama pemohon");
                              }
                              if (!regex.hasMatch(value)) {
                                return ("masukkan minimum 5 aksara");
                              }
                              return null;
                            },
                            onSaved: (value) {
                              pemohonController.text = value!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              labelText: 'Nama penuh pemohon',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Description
                          Row(
                            children: [
                              const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 9.w,
                              ),
                              Text(
                                'Pasangan',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          TextFormField(
                            controller: pasanganController,
                            autofocus: false,
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.name,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              RegExp regex = RegExp(r'^.{5,}$');
                              if (value!.isEmpty) {
                                return ("Sila isi nama pasangan");
                              }
                              if (!regex.hasMatch(value)) {
                                return ("masukkan minimum 2 huruf");
                              }
                              return null;
                            },
                            onSaved: (value) {
                              pasanganController.text = value!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              labelText: 'Nama penuh pasangan',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Tarikh
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month,
                                color: Colors.teal,
                              ),
                              SizedBox(
                                width: 9.w,
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
                          const SizedBox(height: 5),

                          //button Tarikh
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  child: Text(
                                    getTarikh(),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onPressed: () {
                                    pickDate(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.white70),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          // Masa
                          Row(
                            children: [
                              const Icon(
                                Icons.punch_clock,
                                color: Colors.orange,
                              ),
                              SizedBox(
                                width: 9.w,
                              ),
                              Text(
                                'Masa',
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

                          //button masa
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  child: Text(
                                    getMasa(),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onPressed: () {
                                    pickTime(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.white70),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: kPrimaryColor),
                                  onPressed: () {
                                    addMohonNikah();
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
                                        Icons.cancel_sharp,
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
      bottomNavigationBar: CustomNavBar(),
    );
  }

  void addMohonNikah() async {
    try {
      EasyLoading.show(status: 'sedang diproses...');
      if (pemohonController.text.isNotEmpty && pasanganController.text.isNotEmpty) {
        await fireStoreService.uploadMohonNikah(
            pemohonController.text, pasanganController.text, date, timeString);
        EasyLoading.showSuccess('Permohonan berjaya ditambah');
        Navigator.of(context).popAndPushNamed('/semak');
        setState(() {});
      }else{
        EasyLoading.showInfo("Sila isi maklumat nikah");
      }

    } catch (e) {
      EasyLoading.showError(e.toString());
    }
  }

  Future pickDate(BuildContext context) async {
    // final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: date ,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));

    if (newDate == null) {
      return;
    } else {
      pickedDate = true;
    }

    setState(() => date = newDate);
  }

  Future pickTime(BuildContext context) async {
    // final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
        context: context, initialTime: time );

    if (newTime == null) {
      return;
    } else {
      pickedTime = true;
    }

    setState(() => time = newTime);
    timeString = time.format(context);
  }
}
