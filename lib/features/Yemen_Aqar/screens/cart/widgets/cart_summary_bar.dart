import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yemen_aqar/common/widgets/mybutton/mybutton.dart';
import 'package:yemen_aqar/utils/constants/app_colors.dart';
import '../../../controller/cart_controller.dart';
import '../../checkout/checkout_screen.dart';

class CartSummaryBar extends StatelessWidget {
  const CartSummaryBar({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    Get.find<CartController>();

    return GetBuilder<CartController>(
      builder: (controller) {
        if (controller.cartItems.isEmpty) {
          return SizedBox.shrink();
        }

        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 12,
                offset: Offset(0, -4),
              ),
            ],
          ),
          padding: EdgeInsets.fromLTRB(w * 0.04, w * 0.04, w * 0.04, w * 0.05),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),

                // زر إتمام الشراء
                MyButtons(
                  textbutton: "إتمام الشراء",
                  onPress: () {
                    // طباعة بيانات السلة
                    print("=== Cart Items ===");

                    // print(
                    //   "Cart Items JSON: ${controller.cartItems.map((e) => e.toJson()).toList()}",
                    // );

                    // التحقق من وجود عناصر
                    if (controller.cartItems.isEmpty) {
                      Get.snackbar(
                        "السلة فارغة",
                        "أضف عقارات إلى السلة أولاً",
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                      return;
                    }

                    // الانتقال إلى صفحة تأكيد الطلب
                    Get.to(
                      () => CheckoutScreen(cartItems: controller.cartItems),
                    );
                  },
                  buttonColor: AppColors.copperTan,
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
