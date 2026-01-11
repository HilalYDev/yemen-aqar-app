// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:yemen_aqar/features/authentication/model/user_model.dart';
import '../../../../data/dataremote/auth/login.dart';
import '../../../../utils/class/statusrequest.dart';
import '../../../../utils/services/my_services.dart';
import '../../../../utils/functions/handingdatacontroller.dart';
import '../../../../utils/popups/toast_utils.dart';
import '../../../../utils/shared_preferences/user_preferences.dart';

class LoginController extends GetxController {
  final LoginData loginData = LoginData(Get.find());
  final MyServices myServices = Get.find();

  final GlobalKey<FormState> formStateLogin = GlobalKey<FormState>();
  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();
  final statusRequest = StatusRequest.none.obs;
  final fcmToken = ''.obs;
  // final rememberMe = false.obs;
  bool rememberMe = false;

  @override
  void onInit() {
    super.onInit();
    _getFcmToken();
    _fillTestData();
  }

  void _fillTestData() {
    phone.text = "777777770";
    password.text = "Pass@735";
  }

  void setRemeberMe() {
    rememberMe = !rememberMe;
    update();
  }

  @override
  void dispose() {
    phone.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> login() async {
    if (!(formStateLogin.currentState?.validate() ?? false)) return;

    _setLoadingStatus();

    try {
      var response = await loginData.login(
        phone.text,
        password.text,
        fcmToken.value,
      );

      statusRequest.value = handlingData(response);

      if (StatusRequest.success == statusRequest.value) {
        _handleLoginResponse(response);
      } else {
        _showErrorMessage(response['message'] ?? "فشل تسجيل الدخول");
      }
    } catch (e) {
      _showErrorMessage("حدث خطأ أثناء تسجيل الدخول: ${e.toString()}");
      debugPrint("Login Error: $e");
    } finally {
      _resetLoadingStatus();
    }
  }

  void _handleLoginResponse(Map<String, dynamic> response) {
    if (response['status'] == "success") {
      var data = response['data'];
      UserModel user = UserModel.fromJson(data);

      bool isApproved = user.approved ?? false;
      if (!isApproved) {
        _showErrorMessage("حسابك غير مفعل. يرجى التحقق من حسابك.");
        UserPreferences.clearAllData();
        Get.toNamed('/verification', arguments: {"phone": phone.text});
        return;
      }

      UserPreferences.saveUserData(user);
      UserPreferences.saveRememberMe(rememberMe);
      _showErrorMessage(response['message']);

      // التحقق من admin_approved
      if (user.adminApproved != true) {
        Get.offAllNamed('/AccountNotActiveScreen');
        return;
      }

      // التحقق من صلاحية الاشتراك
      if (!UserPreferences.isUserSubscriptionActive()) {
        Get.offAllNamed('/AccountExpiredScreen');
        return;
      }

      // ✅ بعد تسجيل الدخول مباشرة: دائماً نعرض الصفحة الرئيسية
      // (بغض النظر عن rememberMe - هذه هي المؤقتة)
      Get.offAllNamed('/NavigationMenu', arguments: {'showBrowse': false});
    } else {
      _showErrorMessage(response['message'] ?? "فشل تسجيل الدخول");
    }
  }

  void _showErrorMessage(String message) {
    ToastUtils.showToast(msg: message);
    statusRequest.value = StatusRequest.failure;
  }

  Future<void> _getFcmToken() async {
    try {
      fcmToken.value = await FirebaseMessaging.instance.getToken() ?? '';
    } catch (e) {
      debugPrint("Error fetching FCM token: $e");
      fcmToken.value = '';
    }
  }

  void _setLoadingStatus() {
    statusRequest.value = StatusRequest.loading;
    update();
  }

  void _resetLoadingStatus() {
    statusRequest.value = StatusRequest.none;
    update();
  }
}
