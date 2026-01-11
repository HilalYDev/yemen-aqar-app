// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:yemen_aqar/common/widgets/texts/text_styles.dart';
import 'package:yemen_aqar/utils/constants/app_colors.dart';
import 'package:yemen_aqar/utils/helpers/launch_service.dart';

class AccountExpiredScreen extends StatelessWidget {
  const AccountExpiredScreen({super.key});

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
              const Icon(Icons.lock_clock, size: 100, color: Colors.red),
              const SizedBox(height: 10),

              const AppTextStyles(
                title: "الحساب منتهي الصلاحية",
                color: Colors.red,
                bold: true,
              ),
              const SizedBox(height: 10),
              AppTextStyles(
                title:
                    "عذرًا، انتهت صلاحية حسابك. يرجى تجديد اشتراكك للاستمرار في استخدام التطبيق.",
                color: AppColors.deepNavy.withOpacity(0.7),
                bold: true,
                maxLine: 3,
                textAlign: TextAlign.center,
                mediumSize: true,
              ),

              const SizedBox(height: 15),

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
