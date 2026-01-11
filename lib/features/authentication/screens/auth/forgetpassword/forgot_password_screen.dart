import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yemen_aqar/common/widgets/texts/text_styles.dart';
import 'package:yemen_aqar/utils/class/statusrequest.dart';

import '../../../../../common/widgets/auth/auth_page.dart';
import '../../../../../common/widgets/mybutton/mybutton.dart';
import '../../../../../utils/class/handlingdataview.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controller/forgetpassword/forgot_password_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ForgotPasswordController());
    Size size = MediaQuery.of(context).size;

    return AuthPage(length: 1, tabs: const [
      Tab(
        text: "هل نسيت كلمة المرور",
      ),
    ], tabViews: [
      GetBuilder<ForgotPasswordController>(
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
                        title: "الرجاء ادخال رقم الهاتف لتلقي رمز التحقق",
                        smallSize: true,
                      ),
                      const SizedBox(height: 20),
                      HelalTextBox(
                        valid: (val) {
                          return Validator.validatePhoneNumber(val);
                        },
                        ctrl: controller.phone,
                        hint: "رقم الهاتف",
                        len: 9,
                        isPhone: true,
                        labeltext: "رقم الهاتف",
                        icon: Iconsax.call, // أيقونة هاتف من iconsax
                      ),
                      const SizedBox(height: 20),
                      MyButtons(
                        textbutton: "فحص",
                        onPress: () {
                          controller.checkPhone();
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
