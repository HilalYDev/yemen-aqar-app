// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yemen_aqar/common/widgets/mybutton/mybutton.dart';
import 'package:yemen_aqar/common/widgets/texts/text_styles.dart';
import 'package:yemen_aqar/utils/constants/app_colors.dart';
import 'package:yemen_aqar/utils/helpers/launch_service.dart';
import 'package:yemen_aqar/utils/shared_preferences/user_preferences.dart';

class AccountNotActiveScreen extends StatelessWidget {
  const AccountNotActiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // أيقونة أو صورة
              const Icon(Icons.error_outline, size: 80, color: Colors.red),
              const SizedBox(height: 20),

              // عنوان الصفحة
              const AppTextStyles(
                title: "الحساب غير مفعل",
                color: Colors.red,
                bold: true,
              ),

              const SizedBox(height: 10),

              AppTextStyles(
                title:
                    "حسابك لم يتم تفعيله بعد. يرجى الانتظار حتى يتم تفعيل حسابك من قبل الإدارة.",
                color: AppColors.deepNavy.withOpacity(0.7),
                bold: true,
                maxLine: 2,
                textAlign: TextAlign.center,
                mediumSize: true,
              ),

              const SizedBox(height: 20),
              MyButtons(
                textbutton: "محاولة مرة أخرى",
                onPress: () {
                  Get.offAllNamed('/SplashScreen');
                },
              ),

              const SizedBox(height: 15),
              MaterialButton(
                onPressed: () {
                  UserPreferences.clearAllData();
                  // Get.offAll(() => const AuthScreen());
                },
                child: const Text("تسجيل خروج"),
              ),
              // زر "الاتصال بالدعم"
              TextButton(
                onPressed: () {
                  LaunchService.launchSupportEmail();
                },
                child: const Text(
                  "الاتصال بالدعم",
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
