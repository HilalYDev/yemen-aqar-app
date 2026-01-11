// ignore_for_file: deprecated_member_use

import 'package:url_launcher/url_launcher.dart';
import 'package:yemen_aqar/utils/popups/toast_utils.dart';

class LaunchService {
  // دالة لفتح واتساب مع رسالة مخصصة تتضمن رقم العقار
  static Future<void> openWhatsApp({
    required String phoneNumber,
    String? propertyNumber,
    String? propertyName,
    String? propertyPrice,
    String message = "مرحبًا، أنا مهتم بالعقار الذي عرضته.", // رقم العقار
  }) async {
    if (propertyNumber != null) {
      message += "\n\nرقم العقار: $propertyNumber";
    }
    if (propertyName != null) {
      message += "\nاسم العقار: $propertyName";
    }
    if (propertyPrice != null) {
      message += "\nالسعر: $propertyPrice";
    }
    // بناء الرابط لفتح واتساب مع الرسالة
    String url = "https://wa.me/$phoneNumber?text=${Uri.encodeFull(message)}";

    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'لا يمكن فتح واتساب باستخدام الرابط: $url';
      }
    } catch (e) {
      // إرجاع الخطأ مع رسالة تفصيلية
      throw 'حدث خطأ عند محاولة فتح واتساب: $e';
    }
  }

  // دالة لفتح تطبيق الهاتف للاتصال
  static Future<void> makePhoneCall(String phoneNumber) async {
    String url = "tel:$phoneNumber";

    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'لا يمكن إجراء الاتصال عبر الرابط: $url';
      }
    } catch (e) {
      // إرجاع الخطأ مع رسالة تفصيلية
      throw 'حدث خطأ عند محاولة الاتصال: $e';
    }
  }

  static Future<void> launchSupportEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'helalalwazzan1@gmail.com',
      queryParameters: {
        'subject': 'تفعيل الحساب',
        'body': 'الرجاء مساعدتي في تفعيل حسابي.',
      },
    );

    try {
      if (await canLaunch(emailUri.toString())) {
        await launch(emailUri.toString());
      } else {
        ToastUtils.showToast(
          msg:
              "تعذر فتح تطبيق البريد الإلكتروني. يرجى التأكد من تثبيت تطبيق بريد إلكتروني على جهازك.",
        );
      }
    } catch (e) {
      ToastUtils.showToast(
        msg: "حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.$e",
      );
    }
  }
}
