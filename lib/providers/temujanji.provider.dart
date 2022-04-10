import 'package:e_masjid/models/temujanji_model.dart';
import 'package:flutter/cupertino.dart';

//
// class TemuJanjiProvider extends ChangeNotifier {
//   List<TemuJanji> temujanjiList;
//
//   TemuJanjiProvider({required this.temujanjiList});
//
//   update() {
//     final box = GetStorage();
//     box.write('temujanjiList', temujanjiList.map((e) => e.toMap()).toList());
//
//     final list = box.read('temujanjiList');
//     print(list);
//     notifyListeners();
//   }
//
//   addTemujanji(TemuJanji temujanji) {
//     temujanjiList.add(temujanji);
//     update();
//   }
//
//   deleteTemujanji(int index) {
//     temujanjiList.removeAt(index);
//     update();
//   }
// }