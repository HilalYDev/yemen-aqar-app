import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/dataremote/checkout_data.dart';
import '../../../utils/class/statusrequest.dart';
import '../../../utils/functions/handingdatacontroller.dart';
import '../../../utils/popups/toast_utils.dart';
import '../../../utils/shared_preferences/user_preferences.dart';
import 'cart_controller.dart';

class CheckoutController extends GetxController {
  CheckoutData checkoutData = CheckoutData(Get.find());

  // StatusRequest? statusRequest = StatusRequest.none;
  StatusRequest statusRequest = StatusRequest.none;

  /// دالة إتمام الطلب
  Future<void> checkout() async {
    statusRequest = StatusRequest.loading; // حالة التحميل
    update();

    try {
      /// إرسال البيانات للسيرفر
      var response = await checkoutData.checkout(UserPreferences.id);

      // التعامل مع البيانات
      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        if (response['status'] == "success") {
          statusRequest = StatusRequest.success;
          update();
          // ✅ تم الطلب بنجاح
          _showErrorMessage(response['message']);
          // ✅ هنا المهم: تفريغ السلة بعد نجاح الطلب
          _clearCartAfterSuccess();

          // الانتقال للصفحة الرئيسية أو صفحة الطلبات
          // أو الصفحة التي تريدها

          // Get.offAll(() => OrdersScreen());

          Get.until((route) => route.isFirst);
        } else {
          // ⚠️ فشل منطقي مثل كل العقارات مباعة
          _showErrorMessage(response['message']);
          statusRequest = StatusRequest.failure;
          update();
        }
      }
    } catch (e) {
      print("❌ Checkout Error: $e");
      _showErrorMessage("حدث خطأ أثناء إتمام الطلب");
      statusRequest = StatusRequest.failure;
      update();
    }
  }

  /// **إظهار رسالة خطأ للمستخدم**
  void _showErrorMessage(String message) {
    ToastUtils.showToast(msg: message);
    statusRequest = StatusRequest.failure;
  }

  /// ✅ دالة تفريغ السلة بعد نجاح الطلب
  void _clearCartAfterSuccess() {
    try {
      final cartController = Get.find<CartController>();
      cartController.clearCart(); // تأكد من وجود هذه الدالة في CartController

      // أو يمكنك عمل هذا
      cartController.cartItems.clear();
      cartController.update();
    } catch (e) {
      debugPrint("⚠️ Error clearing cart: $e");
    }
  }
}
