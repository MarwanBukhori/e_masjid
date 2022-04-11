import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_masjid/models/temujanji_model.dart';

Future<List<TemuJanji>> getTaskList() async {
  final snapshot = await FirebaseFirestore.instance
      .collection('temujanji')
      // .where('authorId', isEqualTo: AppUser().user!.uid)
      .get();
  return snapshot.docs.map((e) => TemuJanji.fromMap(e.data())).toList();
}

Stream<List<TemuJanji>> getTaskListStream() {
  final snapshots = FirebaseFirestore.instance
      .collection('temujanji')
      // .where('authorId', isEqualTo: AppUser().user!.uid)
      // .orderBy('createdDate', descending: true)
      .snapshots();
  return snapshots.map((snapshot) => snapshot.docs
      .map(
        (e) => TemuJanji.fromMap(e.data(), id: e.id),
  )
      .toList());
}

Future<bool> addTask(TemuJanji temujanji) async {
  try {
    await FirebaseFirestore.instance.collection('temujanji').add(temujanji.toMap());
    return true;
  } catch (e) {
    print(e);
    throw (e);
  }
}

Future<bool> deleteTemujanji(String temujanjiID) async {
  try {
    await FirebaseFirestore.instance.doc('temujanji/$temujanjiID').delete();
    return true;
  } catch (e) {
    print(e);
    throw (e);
  }
}