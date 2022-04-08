import 'dart:ffi';

// import 'package:cloud_firestore/cloud_firestore.dart';

class TemuJanji{
  String ?TemuJanjiID;
  String type;
  String ?KariahID;
  String ?PetugasID;
  String title;
  String description;
  DateTime? date;
  Bool privacy;

  TemuJanji({
    this.TemuJanjiID,
    required this.type,
    this.KariahID,
    this.PetugasID,
    required this.title,
    required this.description,
    required this.date,
    required this.privacy,
  });

  // static TemuJanji fromMap(Map<String, dynamic> data, {String? id}) {
  //
  //   try{
  //     return TemuJanji(
  //         title: data['title'] ?? '',
  //         description: data['description'] ?? '',
  //         author: data['author'] ?? '',
  //         id: id,
  //         createdDate: data['createdDate'] !=null
  //             ? (data['createdDate'] as Timestamp).toDate()
  //             : null);
  //
  //   }catch(e){
  //     print(e);
  //     throw(e);
  //   }
  //
  // }

  //to convert object to map string dynamic
  // Map<String, Object?> toMap() {
  //   return {
  //     'title': title,
  //     'description': description,
  //     'author': author,
  //     'createdDate' : createdDate
  //   };
  // }


}