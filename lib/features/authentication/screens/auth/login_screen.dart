import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yemen_aqar/common/widgets/mybutton/mybutton.dart';
import 'package:yemen_aqar/common/widgets/texts/text_styles.dart';
import 'package:yemen_aqar/utils/class/handlingdataview.dart';
import 'package:yemen_aqar/utils/constants/app_colors.dart';
import '../../../../utils/class/statusrequest.dart';
import '../../../../utils/validators/validation.dart';
import '../../controller/auth/login_controller.dart';
import 'forgetpassword/forgot_password_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // تهيئة LoginController
    Get.put(LoginController());
    return GetBuilder<LoginController>(
      builder: (controller) => HandlingDataView(
        statusRequest: controller.statusRequest.value,
        widget: Container(
          padding: const EdgeInsets.all(8),
          child: Form(
            key: controller.formStateLogin,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // حقل إدخال رقم الهاتف
                  HelalTextBox(
                    valid: (val) {
                      return Validator.validatePhoneNumber(val);
                    },
                    ctrl: controller.phone,
                    hint: "رقم الهاتف",
                    len: 10,
                    isPhone: true,
                    labeltext: "رقم الهاتف",
                  ),
                  const SizedBox(height: 20),
                  // حقل إدخال كلمة المرور
                  HelalTextBox(
                    ctrl: controller.password,
                    hint: "كلمة المرور",
                    len: 20,
                    isPassword: true,
                    labeltext: "كلمة المرور",
                    icon: Icons.lock,
                    valid: (val) {
                      return Validator.validatePassword(val);
                    },
                  ),
                  // const SizedBox(height: 20),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            side: const BorderSide(
                              color: AppColors.copperTan, // لون الإطار
                              width: 2.0, // سمك الإطار
                            ),
                            activeColor: AppColors.deepNavy,
                            // checkColor: AppColors.copperTan,

                            value: controller.rememberMe,
                            onChanged: (value) {
                              controller.setRemeberMe();
                            },
                          ),
                          const AppTextStyles(
                            title: 'تذكرني',
                            smallSize: true,
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(() => const ForgotPasswordScreen());
                        },
                        child: const Text(
                          "هل نسيت كلمة المرور؟",
                          style: TextStyle(color: AppColors.copperTan),
                        ),
                      ),
                    ],
                  ),
                  // زر "هل نسيت كلمة المرور؟"

                  const SizedBox(height: 20),
                  // زر "دخول"
                  MyButtons(
                    textbutton: "دخول",
                    onPress: () {
                      controller.login(); // استدعاء دالة تسجيل الدخول
                    },
                    buttonColor: AppColors.copperTan,
                    isLoading: controller.statusRequest.value ==
                        StatusRequest.loading, // حالة التحميل
                  ),
                ],
              ),
            ),
          ),
        ),
        // showLoadingOnlyOnButton: true, // إظهار التحميل فقط على الزر
      ),
    );
  }
}
