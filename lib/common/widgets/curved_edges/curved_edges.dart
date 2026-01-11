import 'package:flutter/material.dart';

// إنشاء Clipper مخصص لرسم الحواف المنحنية
class CurvedEdges extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path(); // إنشاء مسار (Path) لرسم الشكل المخصص

    // بدء المسار من أعلى اليسار (0,0) إلى أسفل اليسار (0, size.height)
    path.lineTo(0, size.height);

    // تحديد نقطة بداية المنحنى الأول (في أسفل الحاوية لكن مرتفع قليلًا بمقدار 20 بكسل)
    final firstCurve = Offset(0, size.height - 20);
    // تحديد نقطة نهاية المنحنى الأول (نقل الخط أفقيًا بمقدار 30 بكسل)
    final lastCurve = Offset(30, size.height - 20);

    // رسم المنحنى الأول باستخدام دالة `quadraticBezierTo`
    path.quadraticBezierTo(
        firstCurve.dx, firstCurve.dy, lastCurve.dx, lastCurve.dy);

    // تحديد بداية المنحنى الثاني على اليسار تقريبًا
    final secondFirstCurve = Offset(0, size.height - 20);
    // تحديد نهاية المنحنى الثاني، وهو يمتد تقريبًا عبر عرض الحاوية
    final secondLastCurve = Offset(size.width - 30, size.height - 20);

    // رسم المنحنى الثاني، وهو أطول ويمتد عبر العرض
    path.quadraticBezierTo(secondFirstCurve.dx, secondFirstCurve.dy,
        secondLastCurve.dx, secondLastCurve.dy);

    // تحديد بداية المنحنى الثالث في الزاوية اليمنى
    final thirdFirstCurve = Offset(size.width, size.height - 20);
    // تحديد نهاية المنحنى الثالث عند أسفل الحافة اليمنى
    final thirdLastCurve = Offset(size.width, size.height);

    // رسم المنحنى الثالث، الذي ينحني عند الحافة اليمنى
    path.quadraticBezierTo(thirdFirstCurve.dx, thirdFirstCurve.dy,
        thirdLastCurve.dx, thirdLastCurve.dy);

    // إكمال المسار بتمديد الخط إلى أعلى يمين الشاشة (إغلاق الشكل)
    path.lineTo(size.width, 0);
    path.close(); // إغلاق الشكل بحيث يتم تعبئته بلون معين عند الاستخدام

    return path; // إرجاع المسار النهائي
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true; // إرجاع `true` لإعادة رسم الشكل في كل مرة يتم التحديث
  }
}
