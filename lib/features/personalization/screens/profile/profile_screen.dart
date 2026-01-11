import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appBar/custom_app_bar.dart';
import '../../../../common/widgets/mybutton/mybutton.dart';
import '../../../../utils/class/handlingdataview.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/shared_preferences/user_preferences.dart';
import '../../../../utils/validators/validation.dart';
import '../../controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProfileController());

    return Scaffold(
      appBar: const CustomAppBar(
        title: "الملف الشخصي",
        color: AppColors.apparcolor,
      ),
      body: GetBuilder<ProfileController>(
        builder: (controller) {
          return HandlingDataView(
            statusRequest: controller.statusRequest!,
            widget: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      // حقل اسم المستخدم
                      HelalTextBox(
                        valid: (val) {
                          return Validator.validateEmptyText(
                            "اسم المستخدم",
                            val,
                          );
                        },
                        ctrl: controller.username,
                        hint: "اسم المستخدم",
                        labeltext: "اسم المستخدم",
                        icon: Iconsax.user,
                      ),
                      const SizedBox(height: 20),

                      // حقل رقم الهاتف
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
                        enabled: false,
                      ),
                      const SizedBox(height: 20),

                      // عرض الحقول من "اسم المكتب" إلى "رقم هاتف المكتب" فقط إذا كان المستخدم Admin
                      if (UserPreferences.isPropertyOwner) ...[
                        HelalTextBox(
                          valid: (val) {
                            return Validator.validateEmptyText(
                              'اسم المكتب',
                              val,
                            );
                          },
                          labeltext: "اسم المكتب",
                          ctrl: controller.officeName,
                          hint: 'اسم المكتب',
                          len: 100,
                          icon: Iconsax.building,
                        ),
                        const SizedBox(height: 20),
                        HelalTextBox(
                          valid: (val) {
                            return Validator.validateEmptyText(
                              "رقم الهوية",
                              val,
                            );
                          },
                          labeltext: "رقم الهوية",
                          ctrl: controller.identityNumber,
                          hint: "رقم الهوية",
                          isNumber: true,
                          icon: Iconsax.card,
                        ),
                        const SizedBox(height: 20),
                        HelalTextBox(
                          valid: (val) {
                            return Validator.validateEmptyText(
                              "السجل التجاري",
                              val,
                            );
                          },
                          ctrl: controller.commercialRegisterImage,
                          hint: "السجل التجاري",
                          labeltext: "السجل التجاري",
                          icon: Iconsax.document,
                        ),
                        const SizedBox(height: 20),
                        HelalTextBox(
                          valid: (val) {
                            return Validator.validateEmptyText(
                              "عنوان المكتب",
                              val,
                            );
                          },
                          ctrl: controller.officeAddress,
                          hint: "عنوان المكتب",
                          labeltext: "عنوان المكتب",
                          icon: Iconsax.location,
                        ),
                        const SizedBox(height: 20),
                        HelalTextBox(
                          valid: (val) {
                            return Validator.validateEmptyText(
                              "رقم هاتف المكتب",
                              val,
                            );
                          },
                          ctrl: controller.officePhone,
                          hint: "رقم هاتف المكتب",
                          labeltext: "رقم هاتف المكتب",
                          len: 9,
                          icon: Iconsax.call_calling,
                        ),
                        const SizedBox(height: 20),
                      ],

                      // زر تحديث الحساب (يظهر للجميع)
                      MyButtons(
                        textbutton: 'تحديث الحساب',
                        onPress: () {
                          controller.saveUserData();
                        },
                      ),
                      const SizedBox(height: 20), // مسافة إضافية في الأسفل
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
