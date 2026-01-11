import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../../../../common/widgets/auth/auth_page.dart';
import '../../../../common/widgets/texts/text_styles.dart';
import '../../../../utils/class/handlingdataview.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../controller/auth/verfiycodesignup_controller.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(VerifyCodeSignUpController());
    return AuthPage(length: 1, tabs: const [
      Tab(text: "كود التحقق"),
    ], tabViews: [
      GetBuilder<VerifyCodeSignUpController>(
        builder: (controller) => HandlingDataRequest(
          statusRequest: controller.statusRequest.value,
          widget: Container(
            padding: const EdgeInsets.all(8),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  AppTextStyles(
                    title:
                        "أدخل كود التحقق الذي تم عبر وتساب إلى الرقم ${controller.phone}",
                    smallSize: true,
                    maxLine: 2,
                    textAlign: TextAlign.center, // ✅ ضبط النص في المنتصف
                  ),
                  const SizedBox(height: 15),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: OtpTextField(
                      fieldWidth: 50.0,
                      borderRadius: BorderRadius.circular(20),
                      numberOfFields: 5,
                      borderColor: AppColors.copperTan,
                      focusedBorderColor: AppColors.deepNavy,
                      showFieldAsBox: true,
                      autoFocus: true,

                      onCodeChanged: (String code) {
                        //handle validation or checks here
                      },
                      onSubmit: (String verificationCode) {
                        controller.verifyCode(verificationCode);
                      }, // end onSubmit
                    ),
                  ),
                  const SizedBox(height: 40),
                  GestureDetector(
                    onTap: () {
                      controller.resendVerifyCode();
                    },
                    child: const Center(
                      child: AppTextStyles(
                        title: "إعادة إرسال رمز التحقق؟",
                        smallSize: true,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      )
    ]);
  }
}
