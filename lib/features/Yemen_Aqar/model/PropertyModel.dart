// ignore_for_file: file_names

class PropertyModel {
  // الحقول الأساسية
  final String? cartId;

  final int? id;
  final String? name;

  // الحقول الاختيارية
  final String? description;
  final String? image;
  final String? ownershipImage;

  // الحقول الإضافية
  final String? price;
  final String? currency;
  final String? location;

  // الحقول المرتبطة بعلاقات
  final String? propertyTypeId;
  final String? propertyTypeName;

  // معلومات المستخدم المرتبط بالعقار
  final String? userId;
  final String? phone;

  // Constructor
  PropertyModel({
    this.cartId,
    this.id,
    this.name,
    this.description,
    this.image,
    this.ownershipImage,
    this.price,
    this.currency,
    this.location,
    this.propertyTypeId,
    this.propertyTypeName,
    this.userId,
    this.phone,
  });

  // ✅ تحويل من JSON إلى Model
  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      // الحقول الأساسية
      cartId: json['cart_id']?.toString(),

      id: json['id'] ?? 0, // ✅ القيمة الافتراضية 0 إذا كانت null
      name: json['name'] ?? 'الاسم غير متوفر',

      // الحقول الاختيارية
      description: json['description'] ?? 'وصف غير متوفر',
      image: json['image'] ?? '', // ✅ القيمة الافتراضية فارغة إذا كانت null
      ownershipImage:
          json['ownership_image'] ??
          '', // ✅ القيمة الافتراضية فارغة إذا كانت null
      // الحقول الإضافية
      price: json['price'] ?? 'غير محدد',
      currency: json['currency'] ?? 'غير محدد',
      location: json['location'] ?? 'غير محدد',

      // الحقول المرتبطة بعلاقات
      // propertyTypeId:
      //     json['property_type_id'] is int ? json['property_type_id'] : 0,
      propertyTypeId: json['property_type_id'].toString(),
      propertyTypeName: json['property_type_name'] ?? 'غير محدد',

      // معلومات المستخدم
      userId: json['user_id'].toString(),
      phone: json['phone'] ?? 'غير متوفر',
    );
  }

  // ✅ تحويل من Model إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'cart_id': cartId,
      // 'quantity': quantity,
      // الحقول الأساسية
      'id': id,
      'name': name,

      // الحقول الاختيارية
      'description': description,
      'image': image,
      'ownership_image': ownershipImage,

      // الحقول الإضافية
      'price': price,
      'currency': currency,
      'location': location,

      // الحقول المرتبطة بعلاقات
      'property_type_id': propertyTypeId,
      'property_type_name': propertyTypeName,

      // معلومات المستخدم
      'user_id': userId,
      'phone': phone,
    };
  }
}
