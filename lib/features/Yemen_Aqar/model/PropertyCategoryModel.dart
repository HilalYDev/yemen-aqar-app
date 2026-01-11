// ignore_for_file: file_names

class PropertyCategoryModel {
  // الحقول الأساسية
  final int? id; // ✅ معرف الفئة
  final String? name; // ✅ اسم الفئة

  // الحقول الاختيارية
  final String? image;

  // الحقول المرتبطة بعلاقات
  final int? propertyCategoryId; // ✅ معرف فئة العقار

  // ✅ Constructor
  PropertyCategoryModel({
    this.id,
    this.name,
    this.image,
    this.propertyCategoryId,
  });

  // ✅ تحويل من JSON إلى Model
  factory PropertyCategoryModel.fromJson(Map<String, dynamic> json) {
    return PropertyCategoryModel(
      // الحقول الأساسية
      id: json['id'] ?? 0, // ✅ القيمة الافتراضية 0 إذا كانت null
      name: json['name'] ?? '', // ✅ القيمة الافتراضية فارغة إذا كانت null

      // الحقول الاختيارية
      image: json['image'] ?? '', // ✅ القيمة الافتراضية فارغة إذا كانت null

      // الحقول المرتبطة بعلاقات
      propertyCategoryId: json['property_category_id'] ??
          0, // ✅ القيمة الافتراضية 0 إذا كانت null
    );
  }

  // ✅ تحويل من Model إلى JSON
  Map<String, dynamic> toJson() {
    return {
      // الحقول الأساسية
      'id': id,
      'name': name,

      // الحقول الاختيارية
      'image': image,

      // الحقول المرتبطة بعلاقات
      'property_category_id': propertyCategoryId,
    };
  }
}
