import 'package:flutter/material.dart';
import 'package:yemen_aqar/utils/constants/app_colors.dart';
import 'package:yemen_aqar/utils/constants/imgaeasset.dart';

import '../../../../common/widgets/images/rounded_images.dart';
import '../../../../common/widgets/texts/text_styles.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text("حول التطبيق"),
        title: const AppTextStyles(title: "حول التطبيق", mediumSize: true),
        centerTitle: true, // لتوسيط عنوان الـ AppBar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // توسيط المحتوى عموديًا
          children: [
            RoundedImage(
              padding: const EdgeInsets.all(10),
              isNetworkImage: false,
              imageUrl: AppImageAsset.logoH,
              height: 200,
              width: 200,
              fit: BoxFit.contain,
              applyImageRadius: true,
              // backgroundColor: AppColor.deepNavy,
              borderRadius: 100,
              border: Border.all(
                color: AppColors.copperTan, // لون الإطار
                width: 10, // سمك الإطار
              ),
            ),

            const SizedBox(height: 20),
            const AppTextStyles(title: "هلال الوزان"),

            const SizedBox(height: 10), // مسافة بين الاسم وإصدار التطبيق
            // إصدار التطبيق
            const Text(
              "الإصدار 1.0.0",
              style: TextStyle(
                fontSize: 18, // حجم الخط
                color: Colors.grey, // لون الخط
              ),
            ),
          ],
        ),
      ),
    );
  }
}
