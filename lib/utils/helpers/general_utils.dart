import 'dart:math';
import 'package:flutter/material.dart';
import 'package:yemen_aqar/utils/constants/app_colors.dart';

class GeneralUtils {
  /// ✅ دالة توليد لون عشوائي
  static Color getRandomColor() {
    final Random random = Random();
    return Color.fromRGBO(
      // random.nextInt(256),
      // random.nextInt(256),
      // random.nextInt(256),
      random.nextInt(100) + 50, // أحمر بين 50 و150
      random.nextInt(100) + 50, // أخضر بين 50 و150
      random.nextInt(100) + 50, // أزرق بين 50 و150
      1, // ثابتة بدون شفافية
    );
  }

  static Color getRandomTwoColors() {
    List<Color> colors = [
      AppColors.copperTan,
      AppColors.deepNavy,
    ];
    return colors[Random().nextInt(2)];
  }

  static final List<Color> telegramColors = [
    const Color(0xFFBB86FC), // Purple
    const Color(0xFF4285F4), // Blue
    const Color(0xFFFF8C00), // Orange
    const Color(0xFF34A853), // Green
    const Color(0xFFEA4335), // Red
    const Color(0xFFF4B400), // Yellow
    const Color(0xFF795548), // Brown
    const Color(0xFF6200EA), // Deep Purple
    const Color(0xFF00897B), // Teal
    const Color(0xFF03A9F4), // Light Blue
  ];

  /// ترجع لون ثابت بناءً على أول حرف من الاسم
  static Color getTelegramColor(String name) {
    if (name.isEmpty) {
      return telegramColors[0]; // لون افتراضي لو كان الاسم فارغًا
    }
    int index = name.codeUnitAt(0) % telegramColors.length;
    return telegramColors[index];
  }

  /// ✅ دالة جلب أول حرف من أي نص
  static String getFirstLetter(String? text) {
    if (text == null || text.isEmpty) return "?"; // إذا كان النص فارغًا أو null
    return text[0].toUpperCase(); // أول حرف كبير
  }
}
