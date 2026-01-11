import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yemen_aqar/utils/services/my_services.dart';

import '../../features/authentication/model/user_model.dart';
import '../constants/user_roles.dart';

class UserPreferences {
  static final myServices = Get.find<MyServices>();
  static SharedPreferences get prefs => myServices.sharedPreferences;

  /// حفظ بيانات المستخدم
  static void saveUserData(UserModel user) {
    try {
      prefs
        ..setString("id", user.id ?? "")
        ..setString("username", user.name ?? "")
        ..setString("phone", user.phone ?? "")
        ..setBool("approve", user.approved ?? false)
        ..setBool("admin_approved", user.adminApproved ?? false)
        ..setString("token", user.token ?? "")
        ..setString("type", user.type ?? "")
        ..setString("expiry_date", user.expiryDate ?? "");
    } catch (e) {
      debugPrint("حدث خطأ أثناء حفظ بيانات المستخدم: $e");
    }
  }

  /// استرجاع بيانات المستخدم
  static UserModel? getUserData() {
    final id = prefs.getString("id");
    final username = prefs.getString("username");
    final phone = prefs.getString("phone");
    final approve = prefs.getBool("approve");
    final adminApproved = prefs.getBool("admin_approved");
    final token = prefs.getString("token");
    final type = prefs.getString("type");
    final expiryDate = prefs.getString("expiry_date");

    if (id == null ||
        username == null ||
        phone == null ||
        approve == null ||
        adminApproved == null ||
        token == null ||
        type == null) {
      return null;
    }

    return UserModel(
      id: id,
      name: username,
      phone: phone,
      approved: approve,
      adminApproved: adminApproved,
      token: token,
      type: type,
      expiryDate: expiryDate,
    );
  }

  /// التحقق من صلاحية الاشتراك
  static bool isUserSubscriptionActive() {
    final expiryDate = prefs.getString("expiry_date");
    if (expiryDate == null || expiryDate.isEmpty) return true;

    try {
      final expiryDateTime = DateTime.parse(expiryDate);
      return DateTime.now().isBefore(expiryDateTime);
    } catch (e) {
      debugPrint("Error parsing expiry date: $e");
      return false;
    }
  }

  // ===== Getters =====
  static String get id => prefs.getString("id") ?? "";
  static String get username => prefs.getString("username") ?? "";
  static String get phone => prefs.getString("phone") ?? "";
  static bool get isApproved => prefs.getBool("approve") ?? false;
  static bool get isAdminApproved => prefs.getBool("admin_approved") ?? false;
  static String get token => prefs.getString("token") ?? "";
  static String get userType => prefs.getString("type") ?? "";
  static String get expiryDate => prefs.getString("expiry_date") ?? "";
  static bool get rememberMe => prefs.getBool('remember_me') ?? false;

  // ===== Roles =====
  static bool get isAdminUser => userType == UserRoles.admin;
  static bool get isPropertyOwner => userType == UserRoles.propertyOwner;
  static bool get isUserUser => userType == UserRoles.user;
  static bool get isClientUser => userType == UserRoles.client;

  /// ✅ هل المستخدم مسجل دخول؟
  static bool get isLoggedIn => getUserData() != null;

  /// حفظ تذكرني
  static Future<void> saveRememberMe(bool rememberMe) async {
    await prefs.setBool('remember_me', rememberMe);
  }

  /// تحديث حقول متعددة
  static void updateFields(Map<String, dynamic> fieldsToUpdate) {
    fieldsToUpdate.forEach((fieldName, newValue) {
      switch (fieldName) {
        case "id":
        case "username":
        case "phone":
        case "token":
        case "type":
        case "expiry_date":
          prefs.setString(fieldName, newValue?.toString() ?? "");
          break;

        case "approve":
        case "admin_approved":
        case "remember_me":
          prefs.setBool(fieldName, newValue == true || newValue == 1);
          break;

        default:
          throw ArgumentError("Invalid field name: $fieldName");
      }
    });
  }

  /// تنظيف بيانات الجلسة (يحافظ على rememberMe)
  static void clearUserSession() {
    // حفظ قيمة rememberMe الحالية
    final bool currentRememberMe = rememberMe;

    // حذف بيانات الجلسة فقط
    prefs.remove("id");
    prefs.remove("username");
    prefs.remove("phone");
    prefs.remove("approve");
    prefs.remove("admin_approved");
    prefs.remove("token");
    prefs.remove("type");
    prefs.remove("expiry_date");

    // إعادة تعيين rememberMe إذا كان true
    if (currentRememberMe) {
      prefs.setBool('remember_me', true);
    }
  }

  /// حذف جميع البيانات (تسجيل خروج كامل)
  static void clearAllData() {
    prefs.clear();
  }

  static void printUserData() {
    final user = UserPreferences.getUserData();

    if (user == null) {
      debugPrint("لا يوجد بيانات مستخدم محفوظة.");
      return;
    }

    debugPrint("===== بيانات المستخدم =====");
    debugPrint("ID: ${user.id}");
    debugPrint("Username: ${user.name}");
    debugPrint("Phone: ${user.phone}");
    debugPrint("Approved: ${user.approved}");
    debugPrint("Admin Approved: ${user.adminApproved}");
    debugPrint("Token: ${user.token}");
    debugPrint("Type: ${user.type}");
    debugPrint("Expiry Date: ${user.expiryDate}");
    debugPrint("===========================");
  }

  /// ✅ دالة جديدة: تنظيف بيانات الجلسة إذا كان rememberMe = false
  static void clearSessionIfNotRemembered() {
    if (!rememberMe) {
      final bool currentRememberMe = rememberMe;

      // حذف بيانات المستخدم فقط
      prefs.remove("id");
      prefs.remove("username");
      prefs.remove("phone");
      prefs.remove("approve");
      prefs.remove("admin_approved");
      prefs.remove("token");
      prefs.remove("type");
      prefs.remove("expiry_date");

      // إعادة تعيين rememberMe إذا كان true
      if (currentRememberMe) {
        prefs.setBool('remember_me', true);
      }
    }
  }

  /// ✅ دالة جديدة: التحقق من أول فتح للتطبيق
  static bool get isFirstOpen => prefs.getBool('first_open') ?? true;

  static void setFirstOpenFalse() {
    prefs.setBool('first_open', false);
  }

  /// ✅ دالة جديدة: التحقق من صلاحيات المستخدم
  static bool hasValidPermissions() {
    final user = getUserData();
    if (user == null) return false;

    return user.adminApproved == true && isUserSubscriptionActive();
  }

  /// ✅ دالة جديدة: هل يجب عرض صفحة التصفح؟
  static bool shouldShowBrowseScreen() {
    // تنظيف الجلسة أولاً
    clearSessionIfNotRemembered();

    final user = getUserData();

    // الحالات التي تعرض Browse:
    // 1. أول مرة
    // 2. لا يوجد مستخدم
    // 3. rememberMe = false
    return isFirstOpen || user == null || !rememberMe;
  }
}
