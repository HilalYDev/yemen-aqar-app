import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:yemen_aqar/common/widgets/shimmer/custom_property_shimmer.dart';
import 'package:yemen_aqar/features/Yemen_Aqar/screens/property_details/property_details_screen.dart';
import 'package:yemen_aqar/utils/constants/app_colors.dart';

import '../../../../common/widgets/appBar/custom_app_bar.dart';
import '../../../../common/widgets/custom_button/custom_button.dart';
import '../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../common/widgets/images/rounded_images.dart';
import '../../../../common/widgets/texts/text_styles.dart';
import '../../../../utils/class/handlingdataview.dart';
import '../../../../utils/helpers/launch_service.dart';
import '../../../../utils/popups/toast_utils.dart';
import '../../../../utils/shared_preferences/user_preferences.dart';
import '../../controller/property/property_controller.dart';
import '../../model/PropertyModel.dart';

class PropertyScreen extends StatelessWidget {
  const PropertyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PropertyController controller = Get.put(PropertyController());

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomAppBar(
        title: controller.name,
        showBackButton: true,
        // rightImages: [const Icon(Iconsax.shopping_cart, color: Colors.black)],
        // onPressEvents: [
        //   () {
        //     Get.to(() => const CartScreen());
        //   },
        // ],

        // color: AppColor.white,
      ),
      floatingActionButton:
          UserPreferences.isPropertyOwner && UserPreferences.isLoggedIn
              ? InkWell(
                onTap: () {
                  Get.toNamed(
                    '/PropertyAddScreen',
                    arguments: {
                      "propertyTypeId": Get.find<PropertyController>().id,
                    },
                  );
                },
                child: RoundedContainer(
                  height: screenWidth * 0.17,
                  width: screenWidth * 0.17,
                  backgroundColor: AppColors.deepNavy,
                  child: const Icon(Icons.add, color: AppColors.copperTan),
                ),
              )
              : null,
      body: GetBuilder<PropertyController>(
        builder: (controller) {
          return HandlingDataRequest(
            widgetLoading: const CustomPropertyShimmer(),
            statusRequest: controller.statusRequest,
            widget: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent &&
                    controller.hasMore) {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    controller.loadMore();
                  });
                }
                return true;
              },
              child: ListView.builder(
                itemCount:
                    controller.property.length + (controller.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == controller.property.length &&
                      controller.hasMore) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  var property = controller.property[index];
                  return GestureDetector(
                    onTap: () {
                      // print("Property Data: ${property.toJson()}");

                      Get.to(() => PropertyDetailsScreen(property: property));
                    },
                    child: RoundedContainer(
                      backgroundColor: AppColors.apparcolor,
                      showShadow: true,
                      padding: EdgeInsets.all(screenWidth * 0.01),
                      // margin: EdgeInsets.all(screenHeight * 0.03),
                      margin: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                        vertical: screenHeight * 0.02,
                      ),
                      child: Row(
                        children: [
                          RoundedImage1(
                            isNetworkImage: true,
                            imageUrl: "${property.image}",
                            height: screenHeight * 0.22,
                            width: screenWidth * 0.3,
                            padding: EdgeInsets.all(screenWidth * 0.02),
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppTextStyles(
                                      title: " ${property.name}",
                                      height: 1.5,
                                      mediumSize: true,
                                    ),
                                    AppTextStyles(
                                      title: "${property.description}",
                                      maxLine: 2,
                                      smallSize: true,
                                      color: AppColors.copperTan,
                                    ),
                                    AppTextStyles(
                                      title:
                                          "السعر: ${property.price} ${property.currency}",
                                      smallSize: true,
                                      height: 2,
                                    ),
                                  ],
                                ),
                                UserPreferences.isLoggedIn
                                    ? Padding(
                                      padding: EdgeInsets.all(
                                        screenWidth * 0.02,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: _buildButtons(
                                          context,
                                          property,
                                          controller,
                                        ),
                                      ),
                                    )
                                    : SizedBox.shrink(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildButtons(
    BuildContext context,
    PropertyModel property,
    PropertyController controller,
  ) {
    // تحقق إذا كان هذا العقار ملك المستخدم الحالي
    bool isMyProperty =
        UserPreferences.isPropertyOwner &&
        property.userId == UserPreferences.id;

    if (isMyProperty) {
      // إذا كان عقار المستخدم نفسه، عرض تعديل وحذف
      return [
        CustomButton(
          iconWidget: Icon(
            Icons.edit,
            color: Colors.white,
            size: MediaQuery.of(context).size.width * 0.05,
          ),
          text: "تعديل",
          backgroundColor: Colors.blue,
          onTap:
              () => Get.toNamed(
                '/EditPropertyScreen',
                arguments: {"property": property},
              ),
        ),
        CustomButton(
          iconWidget: Icon(
            Icons.delete,
            color: Colors.white,
            size: MediaQuery.of(context).size.width * 0.05,
          ),
          text: "حذف",
          backgroundColor: Colors.red,
          onTap: () => controller.deleteProperty(property.id.toString()),
        ),
      ];
    } else {
      // إذا لم يكن ملك المستخدم، عرض أزرار التواصل فقط
      return [
        CustomButton(
          iconWidget: Icon(
            FontAwesomeIcons.whatsapp,
            color: Colors.white,
            size: MediaQuery.of(context).size.width * 0.05,
          ),
          text: "واتساب",
          backgroundColor: AppColors.deepNavy,
          onTap: () async {
            try {
              await LaunchService.openWhatsApp(
                phoneNumber: property.phone.toString(),
                propertyNumber: property.id.toString(),
                propertyName: property.name,
                propertyPrice: "${property.price} ${property.currency}",
                message: "مرحبًا، أنا مهتم بالعقار الذي عرضته.",
              );
            } catch (e) {
              ToastUtils.showToast(msg: "$e");
            }
          },
        ),
        CustomButton(
          iconWidget: Icon(
            Icons.phone,
            color: Colors.white,
            size: MediaQuery.of(context).size.width * 0.05,
          ),
          text: "اتصال",
          backgroundColor: AppColors.copperTan,
          onTap: () async {
            try {
              await LaunchService.makePhoneCall(property.phone.toString());
            } catch (e) {
              ToastUtils.showToast(msg: "$e");
            }
          },
        ),
      ];
    }
  }
}
