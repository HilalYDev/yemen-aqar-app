import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/class/statusrequest.dart';
import '../../../utils/popups/toast_utils.dart';
import '../../../utils/shared_preferences/user_preferences.dart';

class ProfileController extends GetxController {
  StatusRequest? statusRequest = StatusRequest.none;

  final username = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final officeName = TextEditingController();
  final identityNumber = TextEditingController();
  final commercialRegisterImage = TextEditingController();
  final officeAddress = TextEditingController();
  final officePhone = TextEditingController();

  @override
  void onInit() {
    initialData();
    super.onInit();
  }

  void initialData() {
    final userData = UserPreferences.getUserData();

    // إذا كانت البيانات موجودة، نقوم بتعبئة وحدات التحكم
    if (userData != null) {
      username.text = userData.name ?? "";
      phone.text = userData.phone ?? "";
    }
  }

  void saveUserData() {
    if (username.text == UserPreferences.username) {
      ToastUtils.showToast(msg: "لم تقم بإجراء أي تغييرات.");

      return;
    }
    UserPreferences.updateFields({
      "username": username.text,
      // "phone":  phone.text,
    });
  }
}
