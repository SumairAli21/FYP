class ClassData {
  final String id;
  final String name;
  final String description;
  final String? imageUrl; // ✅ Make sure this exists

  ClassData({
    required this.id,
    required this.name,
    required this.description,
    this.imageUrl, // ✅ Optional
  });

  factory ClassData.fromFirestore(String id, Map<String, dynamic> data) {
    print("🔍 Parsing class data: $data");
    
    final name = data['name'] ?? 'Unnamed Class';
    final description = data['description'] ?? '';
    final imageUrl = data['imageUrl'] as String?; // ✅ Get imageUrl
    
    print("✅ Parsed - Name: $name, ImageURL: $imageUrl");
    
    return ClassData(
      id: id,
      name: name,
      description: description,
      imageUrl: imageUrl, // ✅ Include imageUrl
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}