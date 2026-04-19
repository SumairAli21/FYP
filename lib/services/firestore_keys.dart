class FirestoreKeys {
  // ===== Collections =====
  static const String classes = 'classes';
  static const String classMembers = 'class_members';
  static const String users = 'users';
  static const String content = 'content';
  static const String maxStudents = 'maxStudents';
  static const String currentStudentCount = 'currentStudentCount';

  // ===== Class fields =====
  static const String className = 'name';
  static const String classDescription = 'description';
  static const String classCode = 'code';
  static const String teacherId = 'teacherId';
  static const String createdAt = 'createdAt';
   static const String imageUrl = 'imageUrl';


  // ===== Member fields =====
  static const String classId = 'classId';
  static const String userId = 'userId';
  static const String role = 'role';
  static const String joinedAt = 'joinedAt';

  // ===== Roles =====
  static const String teacher = 'teacher';
  static const String student = 'student';

  // ===== Content fields (future) =====
 static const String lessons = 'lessons';
  static const String lessonTitle = 'title';
  static const String lessonDescription = 'description';
  static const String lessonContentUrl = 'contentUrl';
  static const String lessonImageUrl = 'imageurl';
}
