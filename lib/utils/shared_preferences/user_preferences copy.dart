// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:yemen_aqar/utils/services/my_services.dart';

// import '../../features/Yemen_Aqar/model/OfficeDetailsModel.dart';
// import '../../features/authentication/model/user_model.dart';
// import '../constants/user_roles.dart';

// class UserPreferences {
//   static final myServices = Get.find<MyServices>();
//   static SharedPreferences get prefs => myServices.sharedPreferences;

//   /// حفظ بيانات المستخدم في SharedPreferences.
//   static void saveUserData(UserModel user) {
//     try {
//       prefs
//         ..setString("id", user.id ?? "")
//         ..setString("username", user.name ?? "")
//         ..setString("phone", user.phone ?? "")
//         ..setBool("approve", user.approved ?? false)
//         ..setBool(
//           "admin_approved",
//           user.adminApproved ?? false,
//         ) // إضافة الحقل الجديد
//         ..setString("token", user.token ?? "")
//         ..setString("type", user.type ?? "")
//         ..setString("expiry_date", user.expiryDate ?? ""); // جعلها تقبل null

//       if (user.officeDetailsModel != null) {
//         var details = user.officeDetailsModel!;
//         prefs
//           ..setString("idnumber", details.identityNumber ?? "")
//           ..setString("image", details.image ?? "")
//           ..setString("office_name", details.officeName ?? "")
//           ..setString("office_address", details.officeAddress ?? "")
//           ..setString("office_phone", details.officePhone ?? "");
//       }
//     } catch (e) {
//       debugPrint("حدث خطأ أثناء حفظ بيانات المستخدم: $e");
//     }
//   }

//   /// مسح جميع بيانات المستخدم.
//   static void clearUserData() {
//     prefs.clear();
//   }

//   /// استرجاع بيانات المستخدم ككائن UserModel.
//   static UserModel? getUserData() {
//     final id = prefs.getString("id");
//     final username = prefs.getString("username");
//     final phone = prefs.getString("phone");
//     final approve = prefs.getBool("approve");
//     final adminApproved = prefs.getBool("admin_approved"); // إضافة الحقل الجديد
//     final token = prefs.getString("token");
//     final type = prefs.getString("type");
//     final expiryDate = prefs.getString("expiry_date"); // يمكن أن تكون null

//     if (id == null ||
//         username == null ||
//         phone == null ||
//         approve == null ||
//         adminApproved == null || // إضافة الحقل الجديد
//         token == null ||
//         type == null) {
//       return null;
//     }

//     final officeDetails =
//         (prefs.getString("idnumber") != null &&
//             prefs.getString("image") != null &&
//             prefs.getString("office_name") != null &&
//             prefs.getString("office_address") != null &&
//             prefs.getString("office_phone") != null)
//         ? OfficeDetailsModel(
//             identityNumber: prefs.getString("idnumber")!,
//             image: prefs.getString("image")!,
//             officeName: prefs.getString("office_name")!,
//             officeAddress: prefs.getString("office_address")!,
//             officePhone: prefs.getString("office_phone")!,
//           )
//         : null;

//     return UserModel(
//       id: id,
//       name: username,
//       phone: phone,
//       approved: approve,
//       adminApproved: adminApproved, // إضافة الحقل الجديد
//       token: token,
//       type: type,
//       expiryDate: expiryDate,
//       officeDetailsModel: officeDetails,
//     );
//   }

//   /// التحقق من صلاحية المستخدم بناءً على تاريخ انتهاء الصلاحية.

//   static bool isUserSubscriptionActive() {
//     final expiryDate = prefs.getString("expiry_date");

//     // إذا كانت expiryDate فارغة أو غير موجودة، يعتبر المستخدم نشطًا
//     if (expiryDate == null || expiryDate.isEmpty) return true;

//     try {
//       final expiryDateTime = DateTime.parse(expiryDate);
//       // إذا كان التاريخ الحالي قبل expiryDateTime، يعتبر المستخدم نشطًا
//       return DateTime.now().isBefore(expiryDateTime);
//     } catch (e) {
//       // في حالة وجود خطأ في تحويل التاريخ، يعتبر المستخدم غير نشط
//       debugPrint("Error parsing expiry date: $e");
//       return false;
//     }
//   }

//   /// تحديث توكن المستخدم.
//   static void updateUserToken(String newToken) {
//     prefs.setString("token", newToken);
//   }

//   /// إعادة تعيين التوكن.
//   static void resetToken() {
//     prefs.remove("token");
//   }

//   // استرجاع البيانات المخزنة كخصائص
//   static String get id => prefs.getString("id") ?? "";
//   static String get username => prefs.getString("username") ?? "";
//   static String get phone => prefs.getString("phone") ?? "";
//   static bool get isApproved => prefs.getBool("approve") ?? false;
//   static bool get isAdminApproved =>
//       prefs.getBool("admin_approved") ?? false; // إضافة الحقل الجديد
//   static String get token => prefs.getString("token") ?? "";
//   static String get userType => prefs.getString("type") ?? "";
//   static String get expiryDate => prefs.getString("expiry_date") ?? "";
//   static bool get rememberMe => prefs.getBool('remember_me') ?? false;

//   // بيانات المكتب (إذا كانت موجودة)
//   static String get idNumber => prefs.getString("idnumber") ?? "";
//   static String get commercialRegister => prefs.getString("image") ?? "";
//   static String get officeName => prefs.getString("office_name") ?? "";
//   static String get officeAddress => prefs.getString("office_address") ?? "";
//   static String get officePhone => prefs.getString("office_phone") ?? "";

//   // تحقق من نوع المستخدم
//   static bool get isAdminUser => userType == UserRoles.admin;
//   static bool get isPropertyOwner => userType == UserRoles.propertyOwner;
//   static bool get isUserUser => userType == UserRoles.user;
//   static bool get isClientUser => userType == UserRoles.client;

//   /// حفظ تفضيل "تذكرني".
//   static Future<void> saveRememberMe(bool rememberMe) async {
//     await prefs.setBool('remember_me', rememberMe);
//   }

//   /// استرجاع تفضيل "تذكرني".
//   static Future<bool> getRememberMe() async {
//     return prefs.getBool('remember_me') ?? false;
//   }

//   /// تحديث عدة حقول معًا.
//   static void updateFields(Map<String, dynamic> fieldsToUpdate) {
//     fieldsToUpdate.forEach((fieldName, newValue) {
//       switch (fieldName) {
//         // الحقول الأساسية
//         case "id":
//           prefs.setString("id", newValue.toString());
//           break;
//         case "username":
//           prefs.setString("username", newValue.toString());
//           break;
//         case "phone":
//           prefs.setString("phone", newValue.toString());
//           break;
//         case "approve":
//           prefs.setBool("approve", newValue == true || newValue == 1);
//           break;
//         case "admin_approved":
//           prefs.setBool("admin_approved", newValue == true || newValue == 1);
//           break;
//         case "token":
//           prefs.setString("token", newValue.toString());
//           break;
//         case "type":
//           prefs.setString("type", newValue.toString());
//           break;
//         case "expiry_date":
//           prefs.setString("expiry_date", newValue?.toString() ?? "");
//           break;

//         // حقول بيانات المكتب
//         case "idnumber":
//           prefs.setString("idnumber", newValue.toString());
//           break;
//         case "image":
//           prefs.setString("image", newValue.toString());
//           break;
//         case "office_name":
//           prefs.setString("office_name", newValue.toString());
//           break;
//         case "office_address":
//           prefs.setString("office_address", newValue.toString());
//           break;
//         case "office_phone":
//           prefs.setString("office_phone", newValue.toString());
//           break;

//         // حقول إضافية
//         case "remember_me":
//           prefs.setBool("remember_me", newValue == true || newValue == 1);
//           break;

//         // إذا كان اسم الحقل غير معروف
//         default:
//           throw ArgumentError("Invalid field name: $fieldName");
//       }
//     });
//   }
// }
