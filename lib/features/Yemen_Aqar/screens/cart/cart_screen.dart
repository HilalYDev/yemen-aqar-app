import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yemen_aqar/common/widgets/shimmer/custom_property_shimmer.dart';
import 'package:yemen_aqar/features/Yemen_Aqar/controller/cart_controller.dart';
import 'package:yemen_aqar/features/Yemen_Aqar/screens/property_details/property_details_screen.dart';
import 'package:yemen_aqar/utils/constants/app_colors.dart';
import '../../../../common/widgets/appBar/custom_app_bar.dart';
import '../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../common/widgets/images/rounded_images.dart';
import '../../../../common/widgets/texts/text_styles.dart';
import '../../../../utils/class/handlingdataview.dart';
import '../../model/PropertyModel.dart';
import 'widgets/cart_summary_bar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    cartController.getData(); // هنا فقط

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const CustomAppBar(title: "سلة المشتريات"),
      body: GetBuilder<CartController>(
        builder: (controller) {
          return HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widgetLoading: const CustomPropertyShimmer(),
            widget:
                controller.cartItems.isEmpty
                    ? Center(
                      child: Text(
                        "السلة فارغة",
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                    : ListView.builder(
                      itemCount: controller.cartItems.length,
                      // itemCount: 10,
                      itemBuilder: (context, index) {
                        PropertyModel property = controller.cartItems[index];

                        return GestureDetector(
                          onTap: () {
                            Get.to(
                              () => PropertyDetailsScreen(property: property),
                            );
                          },
                          child: RoundedContainer(
                            backgroundColor: AppColors.apparcolor,
                            showShadow: true,
                            padding: EdgeInsets.all(screenWidth * 0.01),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AppTextStyles(
                                            title: "${property.name}",
                                            // title: "{property.name}",
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

                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton.icon(
                                          onPressed: () {
                                            cartController.deleteCart(
                                              property.cartId!,
                                            );
                                            // print(property.cartId!);
                                          },
                                          icon: const Icon(
                                            Icons.delete_outline,
                                          ),
                                          label: const Text("إزالة من السلة"),

                                          style: ElevatedButton.styleFrom(
                                            minimumSize: const Size(
                                              double.infinity,
                                              10,
                                            ), // 🔥 التحكم بالارتفاع
                                            backgroundColor: Colors.red,
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
          );
        },
      ),
      bottomNavigationBar: CartSummaryBar(),
    );
  }
}
