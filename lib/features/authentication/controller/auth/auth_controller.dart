import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yemen_aqar/data/dataremote/auth/auth.dart';
import 'package:yemen_aqar/features/authentication/model/user_model.dart';
import 'package:yemen_aqar/utils/shared_preferences/user_preferences.dart';

class AuthController extends GetxController {
  final AuthData _authData = AuthData();

  /// تحديث بيانات المستخدم من السيرفر
  Future<void> updateUserFromServer() async {
    try {
      // فقط إذا كان rememberMe = true
      if (!UserPreferences.rememberMe) {
        return;
      }

      if (UserPreferences.id.isEmpty || UserPreferences.phone.isEmpty) {
        return;
      }

      var response = await _authData.getUserData(
        UserPreferences.id,
        UserPreferences.phone,
      );

      debugPrint("=============================== Controller $response");

      if (response['status'] == 'success') {
        final userData = response['data'];
        UserModel user = UserModel.fromJson(userData);

        // تحديث البيانات المحلية
        UserPreferences.updateFields({
          "admin_approved": user.adminApproved,
          "expiry_date": user.expiryDate,
        });
      }
    } catch (e) {
      debugPrint("Error updating user from server: $e");
    }
  }

  /// التحقق من حالة المستخدم الحالية
  Map<String, dynamic> getUserStatus() {
    final user = UserPreferences.getUserData();
    final bool rememberMe = UserPreferences.rememberMe;

    return {
      'hasUser': user != null,
      'rememberMe': rememberMe,
      'adminApproved': user?.adminApproved ?? false,
      'subscriptionActive': UserPreferences.isUserSubscriptionActive(),
    };
  }
}

// class AuthController extends GetxController {
//   final AuthData _authData = AuthData();

//   @override
//   void onInit() {
//     getUser();
//     super.onInit();
//   }

//   Future<void> getUser() async {
//     // التحقق من أن id و phone ليسا فارغين
//     if (UserPreferences.id.isEmpty || UserPreferences.phone.isEmpty) {
//       debugPrint("=============================== Error: ID or Phone is empty");
//       return; // إيقاف الدالة إذا كانت القيم فارغة
//     }

//     var response = await _authData.getUserData(
//       UserPreferences.id,
//       UserPreferences.phone,
//     );
//     debugPrint("=============================== Controller $response");

//     // التحقق من أن البيانات تم جلبها بنجاح
//     if (response['status'] == 'success') {
//       final userData = response['data'];
//       UserModel user = UserModel.fromJson(userData);
//       UserPreferences.updateFields({
//         "admin_approved": user.adminApproved,
//         "expiry_date": user.expiryDate,
//       });
//       debugPrint("${UserPreferences.id}");
//     } else {
//       UserPreferences.clearUserData();
//     }
//   }
// }
