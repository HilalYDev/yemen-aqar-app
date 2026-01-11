import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/dataremote/auth/verfiycodesignup.dart';
import '../../../../utils/class/statusrequest.dart';
import '../../../../utils/functions/handingdatacontroller.dart';
import '../../../../utils/popups/toast_utils.dart';
import '../../../../utils/services/my_services.dart';
import '../../../../utils/shared_preferences/user_preferences.dart';
import '../../model/user_model.dart';

class VerifyCodeSignUpController extends GetxController {
  final VerfiyCodeData verfiyCodeData = VerfiyCodeData(Get.find());
  final MyServices myServices = Get.find();

  // حالة الطلب
  final statusRequest = StatusRequest.none.obs;

  // بيانات المستخدم
  final phone = ''.obs;
  final username = ''.obs;
  final isResetPassword =
      false.obs; // لتحديد ما إذا كانت العملية لإعادة تعيين كلمة المرور

  @override
  void onInit() {
    super.onInit();
    phone.value = Get.arguments['phone'] ?? '';
    isResetPassword.value = Get.arguments['isResetPassword'] ?? false;
    username.value = myServices.sharedPreferences.getString("username") ?? '';
  }

  // ✅ دالة التحقق من الرمز
  Future<void> verifyCode(String verifyCode) async {
    try {
      _setLoadingStatus();

      var response = await verfiyCodeData.verifyPhone(phone.value, verifyCode);
      // debugPrint("=============================== Controller $response");

      statusRequest.value = handlingData(response);

      if (statusRequest.value == StatusRequest.success) {
        _handleVerificationResponse(response);
      } else {
        _showErrorMessage("Failed to verify the code. Please try again.");
      }
    } catch (e) {
      _handleRequestError(e);
    } finally {
      update();
    }
  }

  // ✅ دالة معالجة الاستجابة بناءً على سياق الاستخدام
  void _handleVerificationResponse(Map<String, dynamic> response) {
    if (response['status'] == "success") {
      if (isResetPassword.value) {
        Get.offAllNamed('/resetPassword', arguments: {"phone": phone.value});
      } else {
        var data = response['data'];
        if (data != null) {
          UserModel user = UserModel.fromJson(data);
          UserPreferences.saveUserData(user);

          if (user.adminApproved ?? false) {
            // Get.offAllNamed('/NavigationMenu');
            Get.offAllNamed(
              '/NavigationMenu',
              arguments: {'showBrowse': false},
            );
          } else {
            Get.offAllNamed('/AccountNotActiveScreen');
          }
        } else {
          _showErrorMessage("No user data found.");
        }
      }
    } else {
      _showErrorMessage("Verify Code Not Correct");
    }
  }

  // دالة لإظهار رسالة الخطأ
  void _showErrorMessage(String message) {
    ToastUtils.showToast(msg: message);
    // statusRequest.value = StatusRequest.failure;
  }

  // دالة لإعداد الحالة إلى تحميل
  void _setLoadingStatus() {
    statusRequest.value = StatusRequest.loading;
    update();
  }

  // دالة لإعادة إرسال رمز التحقق
  Future<void> resendVerifyCode() async {
    try {
      if (phone.value.isEmpty) {
        throw Exception("Phone number is not available.");
      }

      // ✅ تحديث الحالة إلى "تحميل"
      _setLoadingStatus();

      // ✅ إرسال طلب لإعادة إرسال رمز التحقق
      var response = await verfiyCodeData.resendVerifyCode(phone.value);

      // ✅ معالجة الاستجابة
      statusRequest.value = handlingData(response);

      if (statusRequest.value == StatusRequest.success) {
        if (response['status'] == "success") {
          // ✅ إظهار رسالة نجاح
          // ToastUtils.showToast(msg: "تم إعادة إرسال رمز التحقق بنجاح.");
          _showErrorMessage(response['message']);
        } else {
          // ✅ إظهار رسالة خطأ إذا فشلت العملية
          _showErrorMessage("فشل في إعادة إرسال رمز التحقق.");
        }
      } else {
        _showErrorMessage("فشل في الاتصال بالخادم.");
      }
    } catch (e) {
      _handleRequestError(e);
    } finally {
      update(); // ✅ تحديث الواجهة بعد الانتهاء
    }
  }

  // دالة للتعامل مع خطأ في الطلبات
  void _handleRequestError(dynamic error) {
    _showErrorMessage("An error occurred. Please try again.");
    debugPrint("Request Error: $error");
  }
}
