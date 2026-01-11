// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:yemen_aqar/utils/services/my_services.dart';

// import '../../features/authentication/model/user_model.dart';
// import '../constants/user_roles.dart';

// class UserPreferences {
//   static final myServices = Get.find<MyServices>();
//   static SharedPreferences get prefs => myServices.sharedPreferences;

//   /// حفظ بيانات المستخدم
//   static void saveUserData(UserModel user) {
//     try {
//       prefs
//         ..setString("id", user.id ?? "")
//         ..setString("username", user.name ?? "")
//         ..setString("phone", user.phone ?? "")
//         ..setBool("approve", user.approved ?? false)
//         ..setBool("admin_approved", user.adminApproved ?? false)
//         ..setString("token", user.token ?? "")
//         ..setString("type", user.type ?? "")
//         ..setString("expiry_date", user.expiryDate ?? "");
//     } catch (e) {
//       debugPrint("حدث خطأ أثناء حفظ بيانات المستخدم: $e");
//     }
//   }

//   // /// مسح جميع بيانات المستخدم
//   // static void clearUserData() {
//   //   prefs.clear();
//   // }

//   /// استرجاع بيانات المستخدم
//   static UserModel? getUserData() {
//     final id = prefs.getString("id");
//     final username = prefs.getString("username");
//     final phone = prefs.getString("phone");
//     final approve = prefs.getBool("approve");
//     final adminApproved = prefs.getBool("admin_approved");
//     final token = prefs.getString("token");
//     final type = prefs.getString("type");
//     final expiryDate = prefs.getString("expiry_date");

//     if (id == null ||
//         username == null ||
//         phone == null ||
//         approve == null ||
//         adminApproved == null ||
//         token == null ||
//         type == null) {
//       return null;
//     }

//     return UserModel(
//       id: id,
//       name: username,
//       phone: phone,
//       approved: approve,
//       adminApproved: adminApproved,
//       token: token,
//       type: type,
//       expiryDate: expiryDate,
//     );
//   }

//   /// التحقق من صلاحية الاشتراك
//   static bool isUserSubscriptionActive() {
//     final expiryDate = prefs.getString("expiry_date");
//     if (expiryDate == null || expiryDate.isEmpty) return true;

//     try {
//       final expiryDateTime = DateTime.parse(expiryDate);
//       return DateTime.now().isBefore(expiryDateTime);
//     } catch (e) {
//       debugPrint("Error parsing expiry date: $e");
//       return false;
//     }
//   }

//   /// تحديث التوكن
//   static void updateUserToken(String newToken) {
//     prefs.setString("token", newToken);
//   }

//   static void resetToken() {
//     prefs.remove("token");
//   }

//   /// التحقق مما إذا كان المستخدم مسجّل دخول
//   /// التحقق مما إذا كان المستخدم مسجّل دخول
//   static bool isUserLoggedIn() {
//     final user = getUserData();
//     // ✅ استخدام null-aware operator لتجنب الخطأ
//     return user != null &&
//         (user.adminApproved ?? false) &&
//         isUserSubscriptionActive();
//   }

//   // ===== Getters =====
//   static String get id => prefs.getString("id") ?? "";
//   static String get username => prefs.getString("username") ?? "";
//   static String get phone => prefs.getString("phone") ?? "";
//   static bool get isApproved => prefs.getBool("approve") ?? false;
//   static bool get isAdminApproved => prefs.getBool("admin_approved") ?? false;
//   static String get token => prefs.getString("token") ?? "";
//   static String get userType => prefs.getString("type") ?? "";
//   static String get expiryDate => prefs.getString("expiry_date") ?? "";
//   static bool get rememberMe => prefs.getBool('remember_me') ?? false;

//   // ===== Roles =====
//   static bool get isAdminUser => userType == UserRoles.admin;
//   static bool get isPropertyOwner => userType == UserRoles.propertyOwner;
//   static bool get isUserUser => userType == UserRoles.user;
//   static bool get isClientUser => userType == UserRoles.client;

//   /// حفظ تذكرني
//   static Future<void> saveRememberMe(bool rememberMe) async {
//     await prefs.setBool('remember_me', rememberMe);
//   }

//   static Future<bool> getRememberMe() async {
//     return prefs.getBool('remember_me') ?? false;
//   }

//   /// تحديث حقول متعددة
//   static void updateFields(Map<String, dynamic> fieldsToUpdate) {
//     fieldsToUpdate.forEach((fieldName, newValue) {
//       switch (fieldName) {
//         case "id":
//         case "username":
//         case "phone":
//         case "token":
//         case "type":
//         case "expiry_date":
//           prefs.setString(fieldName, newValue?.toString() ?? "");
//           break;

//         case "approve":
//         case "admin_approved":
//         case "remember_me":
//           prefs.setBool(fieldName, newValue == true || newValue == 1);
//           break;

//         default:
//           throw ArgumentError("Invalid field name: $fieldName");
//       }
//     });
//   }

//   // ===== First Open =====
//   static bool get isFirstOpen => prefs.getBool('first_open') ?? true;

//   static Future<void> setFirstOpenFalse() async {
//     await prefs.setBool('first_open', false);
//   }

//   // ===== Clear User (without rememberMe) =====
//   static void clearUserData() {
//     final remember = rememberMe;
//     final firstOpen = isFirstOpen;

//     prefs.clear();

//     prefs.setBool('remember_me', remember);
//     prefs.setBool('first_open', firstOpen);
//   }

//   static void clearUserSessionIfNeeded() {
//     final user = getUserData();
//     final remember = rememberMe;

//     if (user != null && remember == false) {
//       // ❗ امسح بيانات المستخدم فقط
//       prefs.remove("id");
//       prefs.remove("username");
//       prefs.remove("phone");
//       prefs.remove("approve");
//       prefs.remove("admin_approved");
//       prefs.remove("token");
//       prefs.remove("type");
//       prefs.remove("expiry_date");
//     }
//   }
// }
