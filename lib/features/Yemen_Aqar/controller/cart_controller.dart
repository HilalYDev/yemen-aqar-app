import 'package:get/get.dart';

import '../../../data/dataremote/cart_data.dart';
import '../../../utils/class/statusrequest.dart';
import '../../../utils/functions/handingdatacontroller.dart';
import '../../../utils/popups/toast_utils.dart';
import '../../../utils/shared_preferences/user_preferences.dart';
import '../model/PropertyModel.dart';

class CartController extends GetxController {
  CartData cartData = CartData(Get.find());

  // StatusRequest? statusRequest = StatusRequest.none;
  StatusRequest statusRequest = StatusRequest.none;

  List<PropertyModel> cartItems = [];

  /// ✅ دالة تفريغ السلة
  Future<void> clearCart() async {
    cartItems.clear();
    statusRequest = StatusRequest.none;

    update();
  }

  Future<void> getData() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await cartData.getData(UserPreferences.id);

    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        cartItems =
            (response['data'] as List)
                .map((item) => PropertyModel.fromJson(item))
                .toList();

        if (cartItems.isEmpty) {
          statusRequest = StatusRequest.noData; // ✅ تمييز لا توجد بيانات
        }
      } else {
        _showErrorMessage(response['message']);

        statusRequest = StatusRequest.failure; // ❌ فشل عام
      }
    }

    update();
  }

  Future<void> addToCart(String propertyId) async {
    statusRequest = StatusRequest.loading; // حالة التحميل
    update();

    try {
      // استدعاء دالة الإضافة من CartData
      var response = await cartData.addToCart(UserPreferences.id, propertyId);

      // print("=============================== CartController $response ");
      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        if (response['status'] == "success") {
          // ✅ تم الإضافة بنجاح
          _showErrorMessage(response['message']);
        } else {
          // فشل الإضافة
          _showErrorMessage(response['message']);
          statusRequest = StatusRequest.failure;
          update();
        }
      }
    } catch (e) {
      _showErrorMessage("حدث خطأ أثناء الإضافة إلى السلة");
      statusRequest = StatusRequest.failure;
      update();
    }
  }

  // ===== حذف عنصر من السلة =====
  Future<void> deleteCart(String cartId) async {
    try {
      var response = await cartData.removeFromCart(cartId, UserPreferences.id);

      // إزالة العنصر من القائمة محليًا
      cartItems.removeWhere((element) => element.cartId.toString() == cartId);

      if (response['status'] == "success") {
        ToastUtils.showToast(msg: response['message']);
      } else {
        ToastUtils.showToast(msg: response['message']);
      }

      update();
    } catch (e) {
      ToastUtils.showToast(msg: "حدث خطأ أثناء حذف العنصر من السلة");
      update();
    }
  }

  // الحصول على عدد العناصر في السلة
  int get itemCount => cartItems.length;

  /// **إظهار رسالة خطأ للمستخدم**
  void _showErrorMessage(String message) {
    ToastUtils.showToast(msg: message);
    statusRequest = StatusRequest.failure;
  }

  double get totalPrice {
    double total = 0;
    for (var item in cartItems) {
      // إزالة أي فواصل قبل التحويل
      String cleanPrice = item.price!.replaceAll(',', '');
      double price = double.tryParse(cleanPrice) ?? 0;
      total += price; // كل عنصر كميةه 1
    }
    return total;
  }
}
