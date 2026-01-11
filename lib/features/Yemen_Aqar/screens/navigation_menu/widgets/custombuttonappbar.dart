import 'package:flutter/material.dart';
import '../../../../../common/widgets/texts/text_styles.dart';
import '../../../../../utils/constants/app_colors.dart';

class CustomButtonAppBar extends StatelessWidget {
  final void Function()? onPressed;
  final String textbutton;
  final IconData icondata;
  final bool? active;

  const CustomButtonAppBar({
    super.key,
    required this.textbutton,
    required this.icondata,
    required this.onPressed,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed, // الضغط هنا بدلاً من onPressed
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icondata,
            size: 24, // ✅ جعل الأيقونات متناسقة
            color: active == true ? AppColors.copperTan : Colors.white,
          ),
          // const SizedBox(height: 4), // ✅ إضافة مسافة بين الأيقونة والنص
          FittedBox(
            // ✅ تصغير النص إذا لزم الأمر
            child: AppTextStyles(
              title: textbutton,
              color: active == true ? AppColors.copperTan : Colors.white,
              mediumSize: true,
              // height: 0,
            ),
          ),
        ],
      ),
    );
  }
}
