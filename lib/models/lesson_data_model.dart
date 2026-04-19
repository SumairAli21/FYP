class LessonData {
  final String id;
  final String classId;
  final String title;
  final String description;
  final String? imageUrl;
  final String? contentUrl;
  final String teacherId;
  final int lessonNumber; // ✅ NEW

  LessonData({
    required this.id,
    required this.classId,
    required this.title,
    required this.description,
    this.imageUrl,
    this.contentUrl,
    required this.teacherId,
    this.lessonNumber = 1,
  });

  factory LessonData.fromFirestore(String id, Map<String, dynamic> data) {
    return LessonData(
      id: id,
      classId: data['classId'] ?? '',
      title: data['title'] ?? 'Untitled',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] as String? ?? data['imageurl'] as String?,
      contentUrl: data['contentUrl'] as String?,
      teacherId: data['teacherId'] ?? '',
      lessonNumber: data['lessonNumber'] as int? ?? 1, // ✅ NEW
    );
  }
}