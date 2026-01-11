import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yemen_aqar/common/widgets/texts/text_styles.dart';
import 'package:yemen_aqar/utils/constants/app_colors.dart'; // استيراد مكتبة Iconsax

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppTextStyles(
          title: "الإشعارات",
          mediumSize: true,
        ),
        centerTitle: true, // لتوسيط عنوان الـ AppBar
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // توسيط المحتوى عموديًا
          children: [
            // أيقونة كبيرة من Iconsax تشير إلى عدم وجود إشعارات
            Icon(
              Iconsax.notification_bing, // أيقونة الإشعارات من Iconsax
              size: 100, // حجم الأيقونة
              color: AppColors.copperTan, // لون الأيقونة
            ),
            SizedBox(height: 20), // مسافة بين الأيقونة والنص
            // نص "لا يوجد إشعارات"
            AppTextStyles(
              title: "لا يوجد إشعارات",
              mediumSize: true,
            ),
          ],
        ),
      ),
    );
  }
}
