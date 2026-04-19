import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englify_app/models/classdata_model.dart';
import 'package:englify_app/services/firestore_keys.dart';

class classroomservice {
  final _classes =
      FirebaseFirestore.instance.collection(FirestoreKeys.classes);
  final _members =
      FirebaseFirestore.instance.collection(FirestoreKeys.classMembers);

  String _generateclasscode() {
    const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const numbers = '0123456789';
    final rand = Random();

    List<String> code = [];

    for (int i = 0; i < 2; i++) {
      code.add(numbers[rand.nextInt(numbers.length)]);
    }

    for (int i = 0; i < 4; i++) {
      code.add(letters[rand.nextInt(letters.length)]);
    }

    code.shuffle(rand);

    return code.join();
  }

  Future<String> createclass({
    required String classname,
    required String teacher_id,
    required String description,
    required int maxstudents,
    String? imageUrl,
  }) async {
    if (maxstudents < 1 || maxstudents > 59) {
      throw Exception("Maximum students must be between 1 and 59");
    }

    final code = _generateclasscode();

    final Map<String, dynamic> classData = {
      FirestoreKeys.className: classname,
      FirestoreKeys.classDescription: description,
      FirestoreKeys.classCode: code,
      FirestoreKeys.teacherId: teacher_id,
      FirestoreKeys.maxStudents: maxstudents,
      FirestoreKeys.currentStudentCount: 0,
      FirestoreKeys.createdAt: FieldValue.serverTimestamp(),
    };

    if (imageUrl != null && imageUrl.isNotEmpty) {
      classData[FirestoreKeys.imageUrl] = imageUrl;
    }

    final classref = await _classes.add(classData);

    await _members.add({
      FirestoreKeys.classId: classref.id,
      FirestoreKeys.userId: teacher_id,
      FirestoreKeys.role: FirestoreKeys.teacher,
      FirestoreKeys.joinedAt: FieldValue.serverTimestamp(),
    });

    print(
        "✅ Class created: $classname with code: $code${imageUrl != null ? ' (with image)' : ''}");
    return code;
  }

  Future<String?> joinclass({
    required String classcode,
    required String studentid,
  }) async {
    final result = await _classes
        .where(FirestoreKeys.classCode, isEqualTo: classcode)
        .get();

    if (result.docs.isEmpty) return "Invalid class code";

    final classdoc = result.docs.first;
    final classData = classdoc.data();

    final existing = await _members
        .where(FirestoreKeys.classId, isEqualTo: classdoc.id)
        .where(FirestoreKeys.userId, isEqualTo: studentid)
        .get();

    if (existing.docs.isNotEmpty) return "Already joined this class";

    final maxStudents = classData[FirestoreKeys.maxStudents] as int;
    final currentCount = classData[FirestoreKeys.currentStudentCount] as int;

    if (currentCount >= maxStudents) {
      return "Class is full (max $maxStudents students)";
    }

    await _members.add({
      FirestoreKeys.classId: classdoc.id,
      FirestoreKeys.userId: studentid,
      FirestoreKeys.role: FirestoreKeys.student,
      FirestoreKeys.joinedAt: FieldValue.serverTimestamp(),
    });

    await _classes.doc(classdoc.id).update({
      FirestoreKeys.currentStudentCount: FieldValue.increment(1),
    });

    print("✅ Student joined class: ${classData[FirestoreKeys.className]}");
    return null;
  }

  Stream<QuerySnapshot> getstudentclasses(String studentid) {
    return _members
        .where(FirestoreKeys.userId, isEqualTo: studentid)
        .where(FirestoreKeys.role, isEqualTo: FirestoreKeys.student)
        .snapshots();
  }

  Stream<QuerySnapshot> getTeacherClasses(String teacherId) {
    return _classes
        .where(FirestoreKeys.teacherId, isEqualTo: teacherId)
        .snapshots();
  }

  Future<List<ClassData>> getStudentClassesData(String studentId) async {
    try {
      print("📊 Fetching classes for student: $studentId");

      final memberSnapshot = await _members
          .where(FirestoreKeys.userId, isEqualTo: studentId)
          .where(FirestoreKeys.role, isEqualTo: FirestoreKeys.student)
          .get();

      print("📊 Found ${memberSnapshot.docs.length} class memberships");

      final List<ClassData> classes = [];

      for (var memberDoc in memberSnapshot.docs) {
        try {
          final classId = memberDoc[FirestoreKeys.classId];
          print("🔍 Fetching class: $classId");

          final classDoc = await _classes.doc(classId).get();

          if (classDoc.exists) {
            final data = classDoc.data() as Map<String, dynamic>;
            print("📦 Class Document Data: $data");

            final classData = ClassData.fromFirestore(classDoc.id, data);
            classes.add(classData);

            print("✅ Added class: ${classData.name}");
          } else {
            print("⚠️ Class document not found: $classId");
          }
        } catch (e) {
          print("❌ Error processing class: $e");
        }
      }

      print("✅ Total classes loaded: ${classes.length}");
      return classes;
    } catch (e) {
      print('❌ Error fetching student classes: $e');
      return [];
    }
  }

  Future<bool> hasStudentJoinedAnyClass(String studentId) async {
    try {
      final snapshot = await _members
          .where(FirestoreKeys.userId, isEqualTo: studentId)
          .where(FirestoreKeys.role, isEqualTo: FirestoreKeys.student)
          .limit(1)
          .get();

      final hasClasses = snapshot.docs.isNotEmpty;
      print("✅ Student has classes: $hasClasses");
      return hasClasses;
    } catch (e) {
      print('❌ Error checking student classes: $e');
      return false;
    }
  }

  Future<ClassData?> getClassById(String classId) async {
    try {
      final classDoc = await _classes.doc(classId).get();

      if (classDoc.exists) {
        return ClassData.fromFirestore(
          classDoc.id,
          classDoc.data() as Map<String, dynamic>,
        );
      }
      return null;
    } catch (e) {
      print('❌ Error fetching class: $e');
      return null;
    }
  }

  
}