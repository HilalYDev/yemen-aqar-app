import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yemen_aqar/features/authentication/controller/auth/auth_controller.dart';
import 'package:yemen_aqar/utils/constants/app_colors.dart';
import 'package:yemen_aqar/utils/constants/imgaeasset.dart';
import 'package:yemen_aqar/utils/shared_preferences/user_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      checkUserStatus();
    });

    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(AppImageAsset.raunak, fit: BoxFit.cover),
          ),

          Container(
            height: double.infinity,
            width: double.infinity,
            color: AppColors.deepNavy.withOpacity(0.7),
          ),

          Center(
            child: SizedBox(
              width: screenWidth * 0.8,
              height: screenWidth * 0.8,
              child: Image.asset(AppImageAsset.logoV, fit: BoxFit.contain),
            ),
          ),
        ],
      ),
    );
  }

  void checkUserStatus() async {
    UserPreferences.printUserData();

    // ✅ الخطوة 1: تنظيف وتحديد ما إذا كان يعرض Browse
    final bool shouldShowBrowse = UserPreferences.shouldShowBrowseScreen();

    // ✅ الحالة 1: أول مرة يفتح التطبيق
    if (UserPreferences.isFirstOpen) {
      UserPreferences.setFirstOpenFalse();
      Get.offAllNamed('/NavigationMenu', arguments: {'showBrowse': true});
      return;
    }

    // ✅ الحالة 2: إذا كان يجب عرض Browse
    if (shouldShowBrowse) {
      Get.offAllNamed('/NavigationMenu', arguments: {'showBrowse': true});
      return;
    }

    // ✅ من هنا: فقط إذا كان rememberMe = true

    // ✅ تحديث البيانات من السيرفر أولاً
    final authController = Get.put(AuthController());
    await authController.updateUserFromServer();

    // ✅ الحصول على البيانات المحدثة
    final updatedUser = UserPreferences.getUserData();

    if (updatedUser == null) {
      Get.offAllNamed('/NavigationMenu', arguments: {'showBrowse': true});
      return;
    }

    // ❌ الحالة 5: غير مفعل من الإدارة
    if (updatedUser.adminApproved != true) {
      Get.offAllNamed('/AccountNotActiveScreen');
      return;
    }

    // ❌ الحالة 6: الاشتراك منتهي
    if (!UserPreferences.isUserSubscriptionActive()) {
      Get.offAllNamed('/AccountExpiredScreen');
      return;
    }

    UserPreferences.printUserData();

    // ✅ الحالة 4: rememberMe = true وكل الصلاحيات صحيحة
    Get.offAllNamed('/NavigationMenu', arguments: {'showBrowse': false});
  }
}
