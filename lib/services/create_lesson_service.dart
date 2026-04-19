import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englify_app/models/lesson_data_model.dart';
import 'package:englify_app/services/firestore_keys.dart';

class CreateLessonService {
  final _lessons = FirebaseFirestore.instance.collection(FirestoreKeys.lessons);

  // ✅ Auto lesson number - count existing lessons for this class then +1
  Future<int> _getNextLessonNumber(String classid) async {
    final snapshot = await _lessons
        .where(FirestoreKeys.classId, isEqualTo: classid)
        .get();
    return snapshot.docs.length + 1;
  }

  Future<String> createlesson({
    required String classid,
    required String teacherid,
    required String lessontitle,
    required String description,
    String? imageurl,
    String? contenturl,
  }) async {
    // ✅ Get auto lesson number before saving
    final lessonNumber = await _getNextLessonNumber(classid);

    final Map<String, dynamic> lessondata = {
      FirestoreKeys.classId: classid,
      FirestoreKeys.lessonTitle: lessontitle,
      FirestoreKeys.teacherId: teacherid,
      FirestoreKeys.lessonDescription: description,
      FirestoreKeys.createdAt: FieldValue.serverTimestamp(),
      'lessonNumber': lessonNumber, // ✅ Auto number
    };

    if (contenturl != null && contenturl.isNotEmpty) {
      lessondata[FirestoreKeys.lessonContentUrl] = contenturl;
    }

    if (imageurl != null && imageurl.isNotEmpty) {
      lessondata['imageUrl'] = imageurl;
    }

    final lessonref = await _lessons.add(lessondata);
    print("✅ Lesson #$lessonNumber created: ${lessonref.id}");
    return lessonref.id;
  }

  Stream<QuerySnapshot> getlessonforclass(String classid) {
    return _lessons
        .where(FirestoreKeys.classId, isEqualTo: classid)
        .orderBy(FirestoreKeys.createdAt, descending: false)
        .snapshots();
  }

  Future<List<LessonData>> getlesssonsdata(String classid) async {
    try {
      final snapshot = await _lessons
          .where(FirestoreKeys.classId, isEqualTo: classid)
          .orderBy(FirestoreKeys.createdAt, descending: false)
          .get();

      return snapshot.docs.map((doc) {
        return LessonData.fromFirestore(
          doc.id,
          doc.data() as Map<String, dynamic>,
        );
      }).toList();
    } catch (e) {
      print("error fetching lessons $e");
      return [];
    }
  }

  Future<void> deleteLesson(String lessonId) async {
    try {
      await _lessons.doc(lessonId).delete();
    } catch (e) {
      print('❌ Error deleting lesson: $e');
    }
  }
}