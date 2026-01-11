import 'package:flutter/material.dart';
import 'package:yemen_aqar/utils/constants/app_colors.dart';

class CustomUserTypeFrame extends StatelessWidget {
  final IconData icon; // الأيقونة
  final String text; // النص
  final bool isSelected; // هل الإطار محدد؟
  final VoidCallback onTap; // دالة عند النقر
  final Color backgroundColor; // لون خلفية ثابت

  const CustomUserTypeFrame({
    super.key,
    required this.icon,
    required this.text,
    required this.isSelected,
    required this.onTap,
    this.backgroundColor = Colors.white, // لون خلفية افتراضي
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.35, // ربع عرض الشاشة
        height:
            MediaQuery.of(context).size.height * 0.05, // 5% من ارتفاع الشاشة
        decoration: BoxDecoration(
          color: backgroundColor, // لون خلفية ثابت
          border: Border.all(
            color: isSelected
                ? AppColors.copperTan
                : AppColors.deepNavy, // لون الإطار يتغير عند التحديد
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20), // زوايا مستديرة بحجم 20
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? AppColors.copperTan
                  : AppColors.deepNavy, // لون الأيقونة يتغير عند التحديد
              size: 20,
            ),
            const SizedBox(width: 5), // مسافة بين الأيقونة والنص
            Text(
              text,
              style: TextStyle(
                color: isSelected
                    ? AppColors.copperTan
                    : AppColors.deepNavy, // لون النص يتغير عند التحديد
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
