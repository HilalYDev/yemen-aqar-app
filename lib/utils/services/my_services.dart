import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../firebase_options.dart';

class MyServices extends GetxService {
  late SharedPreferences sharedPreferences;

  Future<MyServices> init() async {
    try {
      // ✅ تهيئة Firebase في الخلفية
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ).timeout(const Duration(seconds: 10));

      // ✅ تهيئة SharedPreferences
      sharedPreferences = await SharedPreferences.getInstance();

      return this;
    } catch (e) {
      debugPrint("Error initializing services: $e");
      // ✅ الاستمرار حتى مع فشل بعض الخدمات
      sharedPreferences = await SharedPreferences.getInstance();
      return this;
    }
  }
}

// تهيئة MyServices
initialServices() async {
  await Get.putAsync(
    () => MyServices().init(),
  ); // تأكد من أنك تستخدم Get.putAsync للتهيئة غير المتزامنة
}
