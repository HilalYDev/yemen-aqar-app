// ignore_for_file: prefer_adjacent_string_concatenation, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/auth/auth_page.dart';
import '../../../../../common/widgets/mybutton/mybutton.dart';

import '../../../../../common/widgets/texts/text_styles.dart';
import '../../../../../utils/class/handlingdataview.dart';
import '../../../../../utils/class/statusrequest.dart';
import '../../../../../utils/constants/media_query_sizes.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controller/forgetpassword/resetpassword_controller.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ResetPasswordController());
    Size size = MediaQuery.of(context).size;
    final mdsizes = MQSizes(context);

    return AuthPage(length: 1, tabs: const [
      Tab(text: 'إعادة تعيين كلمة المرور'),
    ], tabViews: [
      GetBuilder<ResetPasswordController>(
          builder: (controller) => HandlingDataView(
              statusRequest: controller.statusRequest.value,
              widget: Container(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.04, // نسبة 2% من ارتفاع الشاشة
                  horizontal: size.width * 0.05, // نسبة 8% من عرض الشاشة
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: controller.formstate,
                    child: Column(children: [
                      const AppTextStyles(
                        title: "الرجاء إعادة تعيين كلمة المرور ",
                        smallSize: true,
                      ),
                      const SizedBox(height: 20),
                      HelalTextBox(
                        ctrl: controller.password,
                        hint: "كلمة المرور",
                        isPassword: true,
                        labeltext: "كلمة المرور",
                        icon: Iconsax.lock, // أيقونة قفل من iconsax
                        valid: (val) {
                          return Validator.validatePassword(val);
                        },
                      ),
                      const SizedBox(height: 20),
                      HelalTextBox(
                        ctrl: controller.repassword,
                        hint: "تأكيد كلمة المرور",
                        len: 20,
                        isPassword: true,
                        labeltext: "تأكيد كلمة المرور",
                        icon: Iconsax.lock, // أيقونة قفل من iconsax
                        valid: (val) {
                          return Validator.validatePassword(val);
                        },
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: mdsizes.spaceBtwInputFields,
                      ),
                      MyButtons(
                        textbutton: "اعادة تعين",
                        onPress: () {
                          controller.resetPassword();
                        },
                        isLoading: controller.statusRequest.value ==
                            StatusRequest.loading,
                      ),
                    ]),
                  ),
                ),
              ))),
    ]);
  }
}
