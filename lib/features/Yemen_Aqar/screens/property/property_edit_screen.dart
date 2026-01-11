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
import '../../controller/property/property_edit_controller.dart';

class PropertyEditScreen extends StatelessWidget {
  const PropertyEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PropertyEditController());

    return Scaffold(
      appBar: const CustomAppBar(
        title: "تعديل العقار",
        color: AppColors.apparcolor,
      ),
      body: GetBuilder<PropertyEditController>(
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

                        // ✅ اسم العقار
                        HelalTextBox(
                          valid:
                              (val) => Validator.validateEmptyText(
                                "اسم العقار",
                                val,
                              ),
                          ctrl: controller.name,
                          hint: "اسم العقار",
                          labeltext: "اسم العقار",
                          icon: Iconsax.home_hashtag5,
                        ),
                        const SizedBox(height: 20),

                        // ✅ تفاصيل العقار
                        HelalTextBox(
                          valid:
                              (val) => Validator.validateEmptyText(
                                "تفاصيل العقار",
                                val,
                              ),
                          ctrl: controller.description,
                          hint: "تفاصيل العقار",
                          labeltext: "تفاصيل العقار",
                          icon: Iconsax.document_text,
                        ),
                        const SizedBox(height: 20),

                        // ✅ سعر العقار والعملة
                        Row(
                          children: [
                            Expanded(
                              child: HelalTextBox(
                                valid:
                                    (val) => Validator.validateEmptyText(
                                      "سعر العقار",
                                      val,
                                    ),
                                ctrl: controller.price,
                                hint: "سعر العقار",
                                labeltext: "سعر العقار",
                                icon: Icons.attach_money,
                                isNumber: true,
                                isFormatted: true,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: CustomDropdown<String>(
                                labelText: "اختر العملة",
                                items: controller.currencies,
                                value: controller.selectedCurrency,
                                onChanged:
                                    (value) =>
                                        controller.updateCurrency(value!),
                                validator:
                                    (value) => Validator.validateEmptyText(
                                      "اختر العملة",
                                      value,
                                    ),
                                prefixIcon: Icons.currency_exchange,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // ✅ موقع العقار
                        HelalTextBox(
                          valid:
                              (val) => Validator.validateEmptyText(
                                "موقع العقار",
                                val,
                              ),
                          ctrl: controller.location,
                          hint: "موقع العقار",
                          labeltext: "موقع العقار",
                          icon: Iconsax.location,
                        ),
                        const SizedBox(height: 20),

                        // ✅ قسم الصور
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ImagePickerWidget(
                              thumbnail: controller.thumbnail,
                              initialImageUrl: controller.imageUrl,
                              chooseThumbnail: controller.chooseThumbnail,
                              title: "تغيير صورة العقار (اختياري)",
                            ),

                            const SizedBox(height: 25),

                            // ✅ صورة الملكية
                            ImagePickerWidget(
                              thumbnail: controller.ownershipImage,
                              initialImageUrl: controller.ownershipImageUrl,
                              chooseThumbnail: controller.chooseOwnershipImage,
                              title: "تغيير صورة الملكية (اختياري)",
                            ),

                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: AppTextStyles(
                                title:
                                    "ملاحظة: يمكنك تغيير صورة الملكية إذا كان لديك مستند أحدث",
                                smallSize: true,
                                color: Colors.red[600],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        // ✅ زر التعديل
                        MyButtons(
                          textbutton: "حفظ التعديلات",
                          onPress: () {
                            controller.updateProperty();
                          },
                          buttonColor: AppColors.copperTan,
                          // isLoading:
                          //     controller.statusRequest == StatusRequest.loading,
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
