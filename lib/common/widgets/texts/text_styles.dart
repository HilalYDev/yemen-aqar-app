import 'package:flutter/material.dart';
import '../../../utils/constants/app_colors.dart';

class AppTextStyles extends StatelessWidget {
  final String title;
  final bool smallSize;
  final bool mediumSize;
  final int maxLine; // عدد الأسطر
  final TextAlign? textAlign;
  final Color? color;
  final double? height;
  final bool bold;
  final TextOverflow? overflow; // إضافة خاصية overflow

  const AppTextStyles({
    super.key,
    required this.title,
    this.smallSize = false,
    this.mediumSize = false,
    this.maxLine = 1, // عدد الأسطر الافتراضي
    this.textAlign = TextAlign.right,
    this.color,
    this.height = 1,
    this.bold = false,
    this.overflow, // overflow اختياري
  });

  @override
  Widget build(BuildContext context) {
    // الحصول على النص المحدد في Theme
    TextStyle? textStyle;

    if (smallSize) {
      textStyle = Theme.of(context).textTheme.titleSmall;
    } else if (mediumSize) {
      textStyle = Theme.of(context).textTheme.titleMedium;
    } else {
      textStyle = Theme.of(context).textTheme.titleLarge;
    }

    return Text(
      title,
      style: textStyle?.copyWith(
        color: color ?? AppColors.deepNavy,
        height: height,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      ),
      maxLines: maxLine, // عدد الأسطر
      textAlign: textAlign,
      overflow: overflow, // استخدام overflow إذا تم تمريره
      textScaler: const TextScaler.linear(1.0),
    );
  }
}
