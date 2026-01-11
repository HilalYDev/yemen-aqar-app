import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:yemen_aqar/common/widgets/mybutton/mybutton.dart';

import '../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../common/widgets/images/rounded_images.dart';
import '../../../../common/widgets/shimmer/custom_property_shimmer.dart';
import '../../../../common/widgets/texts/text_styles.dart';
import '../../../../utils/class/handlingdataview.dart';
import '../../../../utils/constants/app_colors.dart';
import 'features/Yemen_Aqar/controller/browse_properties_controller.dart';
import 'features/Yemen_Aqar/model/PropertyModel.dart';
import 'utils/constants/imgaeasset.dart';
import 'utils/shared_preferences/user_preferences.dart';

class BrowsePropertiesScreen extends StatelessWidget {
  const BrowsePropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BrowsePropertiesController());
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GetBuilder<BrowsePropertiesController>(
      builder: (controller) {
        return HandlingDataRequest(
          statusRequest: controller.statusRequest,
          widgetLoading: const CustomPropertyShimmer(),
          widget:
              controller.properties.isEmpty
                  ? const Center(
                    child: Text(
                      "لا توجد عقارات",
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                  : SingleChildScrollView(
                    child: Column(
                      children: [
                        // شعار أو هيدر
                        Padding(
                          padding: EdgeInsets.only(
                            left: screenWidth * 0.1,
                            right: screenWidth * 0.1,
                            top: 21,
                          ),
                          child: RoundedContainer(
                            height: screenHeight * 0.17,
                            width: screenWidth,
                            backgroundColor: AppColors.apparcolor,
                            showShadow: true,
                            child: const RoundedImage(
                              imageUrl: AppImageAsset.logoH,
                              fit: BoxFit.contain,
                              padding: EdgeInsets.all(10),
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),

                        // قائمة العقارات
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.properties.length,
                          itemBuilder: (context, index) {
                            final PropertyModel property =
                                controller.properties[index];

                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.03,
                                vertical: screenHeight * 0.01,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  showLoginRequiredDialog();
                                },
                                child: RoundedContainer(
                                  backgroundColor: AppColors.apparcolor,
                                  showShadow: true,
                                  padding: EdgeInsets.all(screenWidth * 0.01),
                                  margin: EdgeInsets.symmetric(
                                    vertical: screenHeight * 0.005,
                                  ),
                                  child: Row(
                                    children: [
                                      RoundedImage1(
                                        isNetworkImage: true,
                                        imageUrl: property.image ?? '',
                                        height: screenHeight * 0.20,
                                        width: screenWidth * 0.3,
                                        padding: EdgeInsets.all(
                                          screenWidth * 0.02,
                                        ),
                                      ),
                                      SizedBox(width: screenWidth * 0.02),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            AppTextStyles(
                                              title: property.name ?? "",
                                              height: 1.5,
                                              mediumSize: true,
                                            ),
                                            const SizedBox(height: 4),
                                            AppTextStyles(
                                              title: property.description ?? "",
                                              maxLine: 2,
                                              smallSize: true,
                                              color: AppColors.copperTan,
                                            ),
                                            const SizedBox(height: 4),
                                            AppTextStyles(
                                              title:
                                                  "السعر: ${property.price} ${property.currency}",
                                              smallSize: true,
                                              height: 1,
                                            ),
                                            AppTextStyles(
                                              title:
                                                  "الموقع: ${property.location}",
                                              smallSize: true,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 15),
                        if (!UserPreferences.isLoggedIn)
                          GestureDetector(
                            onTap: () {
                              Get.toNamed('/AuthScreen');
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.01,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.login,
                                    size: 18,
                                    color: AppColors.copperTan,
                                  ),
                                  SizedBox(width: 8),
                                  AppTextStyles(
                                    title:
                                        "انتهت العقارات! لتصفح المزيد سجل دخولك",
                                    smallSize: true,
                                    color: AppColors.deepNavy,
                                  ),
                                ],
                              ),
                            ),
                          ),

                        const SizedBox(height: 15),

                        // ✅ وسائل التواصل الاجتماعي
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.01,
                          ),
                          child: Column(
                            children: [
                              AppTextStyles(
                                title: "تابعنا على وسائل التواصل الاجتماعي",
                                mediumSize: true,
                                bold: true,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.facebook,
                                      color: Colors.blue,
                                      size: 32,
                                    ),
                                    onPressed: () {
                                      // LaunchService.openUrl(
                                      //   "https://www.facebook.com",
                                      // );
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      FontAwesomeIcons.whatsapp,
                                      color: Colors.green,
                                      size: 32,
                                    ),
                                    onPressed: () {
                                      // LaunchService.openUrl(
                                      //   "https://wa.me/xxxxxxxxxxx",
                                      // );
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.email,
                                      color: Colors.red,
                                      size: 32,
                                    ),
                                    onPressed: () {
                                      // LaunchService.openUrl(
                                      //   "mailto:info@example.com",
                                      // );
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.link,
                                      color: Colors.black,
                                      size: 32,
                                    ),
                                    onPressed: () {
                                      // LaunchService.openUrl(
                                      //   "https://www.example.com",
                                      // );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),

                        // ✅ رسالة نهاية العقارات
                      ],
                    ),
                  ),
        );
      },
    );
  }
}

void showLoginRequiredDialog() {
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.lock_outline, size: 50, color: AppColors.deepNavy),
            const SizedBox(height: 15),
            const Text(
              "الدخول مطلوب",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "يرجى تسجيل الدخول للوصول إلى تفاصيل العقار.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Get.back(),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      "ربما لاحقاً",
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.deepNavy,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: MyButtons(
                    textbutton: "تسجيل الدخول",
                    buttonColor: AppColors.deepNavy,
                    onPress: () {
                      Get.back();
                      Get.toNamed('/AuthScreen');
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: false,
  );
}
