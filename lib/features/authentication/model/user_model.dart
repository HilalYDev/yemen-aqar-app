class UserModel {
  String? id;
  String? name;
  String? phone;
  bool? approved;
  bool? adminApproved; // إضافة الحقل الجديد
  String? token;
  String? type;
  final String? expiryDate; // جعلها تقبل null

  UserModel({
    this.id,
    this.name,
    this.phone,
    this.approved,
    this.adminApproved, // إضافة الحقل الجديد
    this.token,
    this.type,
    this.expiryDate,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '0', // افتراض قيمة id إذا كانت null
      name: json['name'] ?? 'غير محدد', // افتراض اسم فارغ إذا كانت null
      phone: json['phone'] ?? 'غير محدد', // افتراض رقم هاتف فارغ إذا كانت null
      approved: json['approved'] == 1, // Assuming 'approved' is 1 for true
      adminApproved: json['admin_approved'] == 1, // إضافة الحقل الجديد
      token: json['token'] ?? '0',
      type: json['type'] ?? 'مستخدم', // افتراض نوع الحساب كمستخدم
      expiryDate: json['expiry_date'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = {
      'id': id,
      'name': name,
      'phone': phone,
      'approved': approved,
      'admin_approved': adminApproved, // إضافة الحقل الجديد
      'token': token,
      'type': type,
      'expiry_date': expiryDate,
    };

    return data;
  }
}
