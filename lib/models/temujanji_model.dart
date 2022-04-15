import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';

class TemuJanji{
  String ?TemuJanjiID;
  String JenisTemuJanji;
  // String ?KariahID;
  // String ?PetugasID;
  String? pemohon;
  String? pasangan;
  String? tajuk;
  String? huraian;
  DateTime? tarikh;
  Bool ?privasi;

  TemuJanji({
    this.TemuJanjiID,
    required this.JenisTemuJanji,
    this.pemohon,
    this.pasangan,
    // this.KariahID,
    // this.PetugasID,
    this.tajuk,
    this.huraian,
    required this.tarikh,
    this.privasi,
  });



  static TemuJanji fromMap(Map<String, dynamic> data, {String? id}) {
    try {
      return TemuJanji(
          TemuJanjiID: data['TemuJanjiID'] ?? '',
          JenisTemuJanji: data['JenisTemuJanji'] ?? '',
          pemohon: data['namaPemohon'],
          pasangan: data['namaPasangan'],
          tajuk: data['Tajuk'] ?? '',
          huraian: data['Huraian'] ?? '',
          tarikh: data['Tarikh'] != null
              ? (data['Tarikh'] as Timestamp).toDate()
              : null);
} catch (e) {
      print(e);
      throw(e);
    }

  }

  // to convert object to map string dynamic
  Map<String, Object?> toMap() {
    return {
      'TemuJanjiID' : TemuJanjiID,
      'JenisTemuJanji' : JenisTemuJanji,
      'Pemohon' : pemohon,
      'Pasangan' : pasangan,
      'Tajuk': tajuk,
      'Huraian': huraian,
      'Tarikh': tarikh,


    };
  }

}

