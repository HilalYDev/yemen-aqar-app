// ignore_for_file: unused_element, no_leading_underscores_for_local_identifiers

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../data/dataremote/forgetpassword/forgetpassword.dart';
import '../../../../utils/class/statusrequest.dart';
import '../../../../utils/functions/handingdatacontroller.dart';
import '../../../../utils/popups/toast_utils.dart';

class ForgotPasswordController extends GetxController {
  final ForgotPasswordData forgotPasswordData = ForgotPasswordData(Get.find());
  final GlobalKey<FormState> formstate = GlobalKey<FormState>();

  // حالة الطلب
  final statusRequest = StatusRequest.none.obs;

  // متحكم حقل إدخال رقم الهاتف
  final TextEditingController phone = TextEditingController();

  @override
  void dispose() {
    phone.dispose();
    super.dispose();
  }

  // ✅ دالة التحقق من رقم الهاتف
  Future<void> checkPhone() async {
    if (!(formstate.currentState?.validate() ?? false)) return;

    _setLoadingStatus(); // تحديث الحالة إلى "تحميل"

    try {
      // محاولة إرسال البيانات إلى الخادم
      final response = await forgotPasswordData.checkPhone(phone.text);
      statusRequest.value = handlingData(response);

      if (statusRequest.value == StatusRequest.success) {
        if (response['status'] == "success") {
          // الانتقال إلى صفحة التحقق من الرمز
          _showErrorMessage(response['message']);
          Get.toNamed('/verification', arguments: {
            "phone": phone.text,
            "isResetPassword":
                true, // ✅ إرسال إشارة عملية إعادة تعيين كلمة المرور
          });
        } else {
          // عرض رسالة في حال عدم العثور على الهاتف
          // _showErrorMessage("Phone Not Found");
          _showErrorMessage(response['message']);
        }
      }
    } catch (error) {
      // في حال حدوث خطأ في الاتصال بالخادم
      _handleRequestError(error);
    } finally {
      _resetLoadingStatus(); // إعادة تعيين الحالة بعد الانتهاء
    }
  }

  // دالة لإظهار رسالة الخطأ
  void _showErrorMessage(String message) {
    ToastUtils.showToast(msg: message);
    statusRequest.value = StatusRequest.failure;
  }

  // دالة للتعامل مع خطأ في الطلبات
  void _handleRequestError(dynamic error) {
    _showErrorMessage("An error occurred. Please try again later.");
    debugPrint("Request Error: $error");
  }

  // دالة لتحديث الحالة إلى "تحميل"
  void _setLoadingStatus() {
    statusRequest.value = StatusRequest.loading;
    update();
  }

  // دالة لإعادة تعيين الحالة إلى "لا شيء"
  void _resetLoadingStatus() {
    statusRequest.value = StatusRequest.none;
    update();
  }
}
