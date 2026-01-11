import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yemen_aqar/common/widgets/images/rounded_images.dart';
import 'package:yemen_aqar/common/widgets/texts/text_styles.dart';
import 'package:yemen_aqar/utils/constants/app_colors.dart';
import '../../../../common/widgets/appBar/custom_app_bar.dart';
import '../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../common/widgets/shimmer/custom_property_shimmer.dart';
import '../../../../utils/class/handlingdataview.dart';
import '../../controller/orders_controller.dart';
import '../../model/OrderModel.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrdersController());

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const CustomAppBar(title: "طلباتي"),
      body: GetBuilder<OrdersController>(
        builder: (controller) {
          return HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widgetLoading: const CustomPropertyShimmer(),

            widget:
                controller.orders.isEmpty
                    ? Center(
                      child: Text(
                        "لا توجد طلبات",
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                    : ListView.builder(
                      itemCount: controller.orders.length,
                      itemBuilder: (context, index) {
                        final OrderModel order = controller.orders[index];

                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.03,
                            vertical: screenHeight * 0.01,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "رقم الطلب: #ORD${order.orderId}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: order.items.length,
                                itemBuilder: (context, i) {
                                  final property = order.items[i].property;
                                  return GestureDetector(
                                    onTap: () {
                                      // يمكن فتح تفاصيل العقار إذا أردت
                                    },
                                    child: RoundedContainer(
                                      backgroundColor: AppColors.apparcolor,
                                      showShadow: true,
                                      padding: EdgeInsets.all(
                                        screenWidth * 0.01,
                                      ),
                                      margin: EdgeInsets.symmetric(
                                        vertical: screenHeight * 0.01,
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                AppTextStyles(
                                                  title: "${property.name}",
                                                  // title: "{property.name}",
                                                  height: 1.5,
                                                  mediumSize: true,
                                                ),
                                                SizedBox(height: 4),
                                                AppTextStyles(
                                                  title:
                                                      "${property.description}",
                                                  maxLine: 2,
                                                  smallSize: true,
                                                  color: AppColors.copperTan,
                                                ),
                                                SizedBox(height: 4),
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
                                                // Text(
                                                //   "الكمية: ${order.items[i].quantity}",
                                                //   style: TextStyle(
                                                //     fontSize: 14,
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Divider(thickness: 2),
                            ],
                          ),
                        );
                      },
                    ),
          );
        },
      ),
    );
  }
}
