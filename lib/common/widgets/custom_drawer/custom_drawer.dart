// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:yemen_aqar/features/Yemen_Aqar/screens/notifications/notifications_screen.dart';
import 'package:yemen_aqar/features/personalization/screens/profile/profile_screen.dart';

import '../../../features/authentication/screens/auth/auth_screen.dart';
import '../../../features/personalization/screens/about_app/about_app_screen.dart';
import '../../../features/personalization/screens/privacy_policy/privacy_policy_screen.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/imgaeasset.dart';
import '../../../utils/shared_preferences/user_preferences.dart';
import '../images/rounded_images.dart';
import '../texts/text_styles.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // رأس القائمة الجانبية مع صورة المستخدم واسم الحساب
          UserAccountsDrawerHeader(
            accountName: AppTextStyles(
              title: UserPreferences.username,
              color: AppColors.copperTan,
            ),
            accountEmail: Text("نوع الحساب : ${UserPreferences.userType}"),
            currentAccountPicture: RoundedImage(
              imageUrl: AppImageAsset.logoV,
              width: 10,
              height: 10,
              fit: BoxFit.cover,
              isNetworkImage: false,
              borderRadius: 50,
              backgroundColor: Colors.transparent,
              border: Border.all(color: AppColors.copperTan, width: 2),
            ),
            decoration: const BoxDecoration(color: AppColors.deepNavy),
          ),

          // القائمة الجانبية (Drawer Items)
          _buildDrawerItem(context, Icons.person, 'الملف الشخصي', () {
            Get.to(() => const ProfileScreen());
          }),
          _buildDrawerItem(context, Icons.notifications, 'الإشعارات', () {
            Get.to(() => const NotificationsScreen());
          }),
          _buildDrawerItem(context, Icons.lock, 'سياسة الخصوصية', () {
            Get.to(() => const PrivacyPolicyScreen());
          }),
          _buildDrawerItem(context, Icons.share, 'مشاركة التطبيق', () {
            Share.share(
              'تحميل تطبيقنا من متجر Google Play: https://play.google.com/store/apps/details?id=com.example.app',
              subject: 'تطبيق رائع!',
            );
          }),
          _buildDrawerItem(context, Icons.info, 'حول التطبيق', () {
            Get.to(() => const AboutAppScreen());
          }),
          _buildDrawerItem(context, Icons.delete, 'حذف الحساب', () {
            Navigator.pop(context); // إغلاق الـ Drawer
            // هنا يمكنك إضافة كود لحذف الحساب
          }),
          _buildDrawerItem(context, Icons.logout, 'تسجيل الخروج', () {
            UserPreferences.clearAllData();
            Get.offAll(() => const AuthScreen());
          }),
        ],
      ),
    );
  }

  // دالة لبناء ListTile مع الحدث المخصص
  Widget _buildDrawerItem(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap, // تمرير الحدث هنا
  ) {
    return ListTile(
      leading: Icon(icon),
      // title: Text(title),
      title: AppTextStyles(title: title, mediumSize: true),
      onTap: onTap, // تعيين الحدث المخصص هنا
    );
  }
}
