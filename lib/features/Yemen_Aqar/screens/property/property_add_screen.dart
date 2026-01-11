import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yemen_aqar/common/widgets/image_picker/image_picker.dart';
import 'package:yemen_aqar/common/widgets/texts/text_styles.dart';

import 'package:yemen_aqar/utils/constants/app_colors.dart';

import '../../../../common/widgets/appBar/custom_app_bar.dart';
import '../../../../common/widgets/drop_down_list/custom_dropdown.dart';
import '../../../../common/widgets/mybutton/mybutton.dart';
import '../../../../utils/class/handlingdataview.dart';
import '../../../../utils/validators/validation.dart';
import '../../controller/property/property_add_controller .dart';

class PropertyAddScreen extends StatelessWidget {
  const PropertyAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PropertyAddController());

    return Scaffold(
      appBar: const CustomAppBar(
        title: "اضافة عقار",
        color: AppColors.apparcolor,
      ),
      body: GetBuilder<PropertyAddController>(
        builder:
            (controller) => HandlingDataRequest(
              statusRequest: controller.statusRequest!,
              widget: Container(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: controller.formStateProperty,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        HelalTextBox(
                          valid: (val) {
                            return Validator.validateEmptyText(
                              "اسم العقار",
                              val,
                            );
                          },
                          ctrl: controller.name,
                          hint: "اسم العقار",
                          labeltext: "اسم العقار",
                          icon:
                              Iconsax
                                  .home_hashtag5, // أيقونة مناسبة لاسم العقار
                        ),
                        const SizedBox(height: 20),
                        HelalTextBox(
                          valid: (val) {
                            return Validator.validateEmptyText(
                              "تفاصيل العقار",
                              val,
                            );
                          },
                          ctrl: controller.description,
                          hint: "تفاصيل العقار",
                          labeltext: "تفاصيل العقار",
                          icon:
                              Iconsax
                                  .document_text, // أيقونة مناسبة لتفاصيل العقار
                        ),
                        const SizedBox(height: 20),

                        // وضع سعر العقار و اختر العملة في صف واحد
                        Row(
                          children: [
                            Expanded(
                              child: HelalTextBox(
                                valid: (val) {
                                  return Validator.validateEmptyText(
                                    "سعر العقار",
                                    val,
                                  );
                                },
                                ctrl: controller.price,
                                hint: "سعر العقار",
                                labeltext: "سعر العقار",
                                icon:
                                    Icons
                                        .attach_money, // أيقونة مناسبة لسعر العقار
                                isNumber: true,
                                isFormatted: true,
                              ),
                            ),
                            const SizedBox(width: 20), // تباعد بين العناصر
                            Expanded(
                              child: CustomDropdown<String>(
                                labelText: "اختر العملة",
                                items: controller.currencies,
                                value: controller.selectedCurrency,
                                onChanged: (value) {
                                  controller.updateCurrency(value!);

                                  // controller.selectedCurrency = newValue!;
                                  // controller.update();
                                },
                                validator: (value) {
                                  return Validator.validateEmptyText(
                                    "اختر العملة",
                                    value,
                                  );
                                },
                                prefixIcon: Icons.currency_exchange,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        HelalTextBox(
                          valid: (val) {
                            return Validator.validateEmptyText(
                              "موقع العقار",
                              val,
                            );
                          },
                          ctrl: controller.location,
                          hint: "موقع العقار",
                          labeltext: "موقع العقار",
                          icon: Iconsax.location, // أيقونة مناسبة لموقع العقار
                        ),
                        const SizedBox(height: 20),

                        ImagePickerWidget(
                          thumbnail: controller.thumbnail,
                          chooseThumbnail: controller.chooseThumbnail,
                        ),
                        const SizedBox(height: 20),
                        ImagePickerWidget(
                          thumbnail: controller.ownershipImage,
                          chooseThumbnail: controller.chooseOwnershipImage,
                          title: "اختر صورة ملكية العقار (مستند الملكية)",
                        ),
                        const SizedBox(height: 10),
                        if (controller.ownershipImage == null)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: AppTextStyles(
                              title:
                                  "ملاحظة: صورة الملكية مهمة لإثبات ملكية العقار",
                              smallSize: true,
                              color: Colors.red[600],
                            ),
                          ),

                        const SizedBox(height: 20),

                        MyButtons(
                          textbutton: "اضافة",
                          onPress: () {
                            controller.addProperty();
                          },
                          buttonColor: AppColors.copperTan,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
