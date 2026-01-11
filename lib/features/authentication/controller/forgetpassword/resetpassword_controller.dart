import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../data/dataremote/forgetpassword/forgetpassword.dart';
import '../../../../utils/class/statusrequest.dart';
import '../../../../utils/functions/handingdatacontroller.dart';
import '../../../../utils/popups/toast_utils.dart';

class ResetPasswordController extends GetxController {
  final GlobalKey<FormState> formstate = GlobalKey<FormState>();
  final ForgotPasswordData forgotPasswordData = ForgotPasswordData(Get.find());

  // حالة الطلب
  final statusRequest = StatusRequest.none.obs;

  // متحكمات حقول النص
  final password = TextEditingController();
  final repassword = TextEditingController();

  // رقم الهاتف
  final phone = ''.obs;

  @override
  void onInit() {
    super.onInit();

    // الحصول على رقم الهاتف من المعلمات المرسلة
    if (Get.arguments != null && Get.arguments['phone'] != null) {
      phone.value = Get.arguments['phone'];
    } else {
      // معالجة الخطأ هنا في حال عدم وجود رقم الهاتف
      _showErrorMessage("Phone number not provided. Please try again.");
      debugPrint("Error: Phone number not provided.");
    }
  }

  @override
  void dispose() {
    // التخلص من حقول النص
    password.dispose();
    repassword.dispose();
    super.dispose();
  }

  // ✅ دالة إعادة تعيين كلمة المرور
  Future<void> resetPassword() async {
    if (password.text != repassword.text) {
      // في حال عدم تطابق كلمتي المرور
      _showErrorMessage("Passwords do not match");
      return;
    }

    if (!(formstate.currentState?.validate() ?? false)) return;

    _setLoadingStatus(); // تحديث الحالة إلى "تحميل"

    try {
      // محاولة إرسال البيانات إلى الخادم
      final response = await forgotPasswordData.resetPassword(
        phone.value,
        password.text,
      );
      statusRequest.value = handlingData(response);

      if (statusRequest.value == StatusRequest.success) {
        if (response['status'] == "success") {
          // الانتقال إلى صفحة النجاح
          Get.offAllNamed('/AuthScreen');
        } else {
          // في حال فشل الطلب من الخادم
          _showErrorMessage("Reset failed, please try again.");
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
