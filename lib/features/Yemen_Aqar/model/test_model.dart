class TestModel {
  final int? id; // ✅ معرف الفئة
  final String? name; // ✅ اسم الفئة
  final String? description; // ✅ وصف الفئة
  final int? propertyCategoryId; // ✅ معرف فئة العقار
  final String? createdAt; // ✅ تاريخ الإنشاء
  final String? updatedAt; // ✅ تاريخ التحديث

  // ✅ Constructor
  TestModel({
     this.id,
     this.name,
     this.description,
     this.propertyCategoryId,
     this.createdAt,
     this.updatedAt,
  });

  // ✅ تحويل من JSON إلى Model
  factory TestModel.fromJson(Map<String, dynamic> json) {
    return TestModel(
      id: json['id'] ?? 0, // ✅ القيمة الافتراضية 0 إذا كانت null
      name: json['name'] ?? '', // ✅ القيمة الافتراضية فارغة إذا كانت null
      description: json['description'] ?? '', // ✅ القيمة الافتراضية فارغة إذا كانت null
      propertyCategoryId: json['property_category_id'] ?? 0, // ✅ القيمة الافتراضية 0 إذا كانت null
      createdAt: json['created_at'] ?? '', // ✅ القيمة الافتراضية فارغة إذا كانت null
      updatedAt: json['updated_at'] ?? '', // ✅ القيمة الافتراضية فارغة إذا كانت null
    );
  }

  // ✅ تحويل من Model إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'property_category_id': propertyCategoryId,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}