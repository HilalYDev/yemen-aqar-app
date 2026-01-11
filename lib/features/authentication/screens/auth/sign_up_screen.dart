import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yemen_aqar/features/authentication/screens/auth/widget/customusertypeframe.dart';
import 'package:yemen_aqar/utils/class/statusrequest.dart';

import '../../../../common/widgets/mybutton/mybutton.dart';
import '../../../../utils/class/handlingdataview.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/validators/validation.dart';
import '../../controller/auth/signup_controller.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpController());
    return GetBuilder<SignUpController>(
      builder: (controller) => HandlingDataView(
        statusRequest: controller.statusRequest.value,
        widget: Container(
          padding: const EdgeInsets.all(8),
          child: Form(
            key: controller.formstateSign,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomUserTypeFrame(
                        icon: Icons.person,
                        text: "فرد",
                        isSelected: controller.userType.value == "user",
                        onTap: () => controller.setUserType("user"),
                      ),

                      // CustomUserTypeFrame(
                      //   icon: Icons.business,
                      //   text: "مكتب",
                      //   isSelected: controller.userType.value == "office",
                      //   onTap: () => controller.setUserType("office"),
                      // ),
                      CustomUserTypeFrame(
                        icon: Icons.home, // يمكن تغيير الايقونة لتمثل مالك عقار
                        text: "مالك عقار",
                        isSelected:
                            controller.userType.value == "property_owner",
                        onTap: () => controller.setUserType("property_owner"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  HelalTextBox(
                    valid: (val) {
                      return Validator.validateEmptyText("اسم المستخدم", val);
                    },
                    ctrl: controller.username,
                    hint: "اسم المستخدم",
                    labeltext: "اسم المستخدم",
                    icon: Iconsax.user,
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
                    icon: Iconsax.call,
                  ),
                  const SizedBox(height: 20),
                  HelalTextBox(
                    ctrl: controller.password,
                    hint: "كلمة المرور",
                    isPassword: true,
                    labeltext: "كلمة المرور",
                    icon: Iconsax.lock,
                    valid: (val) {
                      return Validator.validatePassword(val);
                    },
                  ),
                  const SizedBox(height: 20),
                  HelalTextBox(
                    ctrl: controller.confirmPassword,
                    hint: "تأكيد كلمة المرور",
                    len: 20,
                    isPassword: true,
                    labeltext: "تأكيد كلمة المرور",
                    icon: Iconsax.lock,
                    valid: (val) {
                      // return Validator.validatePassword(val);
                      if (controller.password.text != val) {
                        return "كلمة المرور غير متطابقة";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  MyButtons(
                    textbutton: "تسجيل",
                    onPress: () {
                      controller.register();

                      // if (controller.userType.value == "user") {
                      //   controller.register();
                      // } else {
                      //   // التحقق من صحة الحقول قبل الانتقال
                      //   if (controller.formstateSign.currentState!.validate()) {
                      //     controller.getToOfficeDetails();
                      //   }
                      // }
                    },
                    textColor: AppColors.copperTan,
                    isLoading:
                        controller.statusRequest.value == StatusRequest.loading,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
