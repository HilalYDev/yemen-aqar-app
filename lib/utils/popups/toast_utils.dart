import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants/app_colors.dart';

class ToastUtils {
  // دالة ثابتة لعرض التوست في أي مكان
  static void showToast({
    required String msg, // الرسالة المراد عرضها

    Color backgroundColor = AppColors.deepNavy, // لون الخلفية الافتراضي (أسود)
  }) {
    Fluttertoast.showToast(
      msg: msg, // الرسالة التي سيتم عرضها في التوست
      toastLength: Toast.LENGTH_SHORT, // تحديد مدة التوست (قصيرة أو طويلة)
      gravity: ToastGravity.BOTTOM, // موقع التوست في الشاشة (أسفل، وسط، أعلى)
      backgroundColor: backgroundColor, // لون خلفية التوست
      textColor: Colors.white, // لون النص داخل التوست
      fontSize: 16.0, // حجم الخط داخل التوست
      timeInSecForIosWeb: 5, // مدة عرض التوست على iOS أو الويب (عدد الثواني)

      webShowClose: true, // عرض زر إغلاق للتوست على الويب
    );
  }
}
