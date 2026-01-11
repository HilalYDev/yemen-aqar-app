// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:yemen_aqar/utils/functions/uplodimegs.dart';
import '../../../../data/dataremote/auth/signup.dart';
import '../../../../utils/class/statusrequest.dart';
import '../../../../utils/functions/handingdatacontroller.dart';
import '../../../../utils/popups/toast_utils.dart';
import '../../../../utils/services/my_services.dart';

class SignUpController extends GetxController {
  final SignupData signupData = SignupData(Get.find());
  final MyServices myServices = Get.find();

  final formstateSign = GlobalKey<FormState>(); // نموذج التسجيل للفرد فقط

  final username = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  // حالة الطلب
  final statusRequest = StatusRequest.none.obs;

  // رمز FCM للإشعارات
  final fcm = ''.obs;

  // نوع المستخدم (فرد فقط الآن)
  final userType = "user".obs;

  File? thumbnail; // يمكن الاحتفاظ بها إذا كنت تريد صورة شخصية، أو حذفها

  Future<void> chooseThumbnail() async {
    thumbnail = await pickSingleImageFromGallery();
    update();
  }

  @override
  void onInit() {
    super.onInit();
    _getFcmToken();
    _fillTestData();
  }

  @override
  void dispose() {
    username.dispose();
    phone.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  // تعبئة بيانات الاختبار (لأغراض التطوير فقط)
  void _fillTestData() {
    username.text = "هلال";
    phone.text = "773355465";
    password.text = "Helal@735";
    confirmPassword.text = "Helal@735";
  }

  /// **دالة التسجيل للفرد فقط**
  Future<void> register() async {
    // if (!formstateSign.currentState!.validate()) return;

    _setLoadingStatus(); // تحديث الحالة إلى "تحميل"

    try {
      // await Future.delayed(const Duration(seconds: 5));

      var response = await signupData.register(
        username.text,
        phone.text,
        password.text,
        userType.value,
        fcm.value,
      );

      debugPrint("==== Controller Response: $response ====");

      statusRequest.value = handlingData(response);
      _handleSignupResponse(response);
    } catch (e) {
      _showErrorMessage("An error occurred. Please try again.");
      debugPrint("Signup Error: $e");
    } finally {
      _resetLoadingStatus(); // إعادة تعيين الحالة بعد الانتهاء
    }
  }

  /// **التعامل مع نجاح التسجيل**
  void _handleSignupResponse(Map<String, dynamic> response) {
    if (response['status'] == "success") {
      Get.toNamed('/verification', arguments: {"phone": phone.text});
    } else {
      _showErrorMessage("Phone Number Or Email Already Exists");
    }
  }

  /// **إظهار رسالة خطأ**
  void _showErrorMessage(String message) {
    ToastUtils.showToast(msg: message);
    statusRequest.value = StatusRequest.failure;
  }

  /// **جلب رمز FCM للإشعارات**
  Future<void> _getFcmToken() async {
    try {
      fcm.value = await FirebaseMessaging.instance.getToken() ?? '';
    } catch (e) {
      debugPrint("Error fetching FCM token: $e");
      fcm.value = '';
    }
  }

  /// **تغيير نوع المستخدم** (يمكن الاحتفاظ بها إذا لاحقًا تريد خيارات أخرى)
  void setUserType(String type) {
    userType.value = type;
    update();
  }

  /// **تحديث الحالة إلى "تحميل"**
  void _setLoadingStatus() {
    statusRequest.value = StatusRequest.loading;
    update();
  }

  /// **إعادة تعيين الحالة إلى "لا شيء"**
  void _resetLoadingStatus() {
    statusRequest.value = StatusRequest.none;
    update();
  }
}
