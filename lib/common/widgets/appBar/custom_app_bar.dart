// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:yemen_aqar/common/widgets/texts/text_styles.dart';
import 'package:yemen_aqar/utils/constants/app_colors.dart';
import '../../../utils/constants/imgaeasset.dart'; // تأكد من المسار الصحيح

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? rightImages; // قائمة العناصر على اليمين (صور أو أيقونات)
  final Color? color;
  final List<VoidCallback>?
  onPressEvents; // قائمة الأحداث الخاصة بالضغط على العناصر
  final bool showBackButton; // إظهار سهم الرجوع
  final bool showLogo; // إظهار الصورة
  // final bool centerTitle; // توسيط العنوان

  const CustomAppBar({
    super.key,
    this.title,
    this.rightImages,
    this.color = AppColors.apparcolor,
    this.onPressEvents,
    this.showBackButton = false, // افتراضيًا لا يظهر سهم الرجوع
    this.showLogo = false, // افتراضيًا لا تظهر الصورة
    // this.centerTitle = true, // افتراضيًا العنوان غير ممركز
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).appBarTheme.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            spreadRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: kToolbarHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // سهم الرجوع
                if (showBackButton)
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),

                // الصورة على اليسار
                if (showLogo)
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Image.asset(
                      AppImageAsset.logoH,
                      fit: BoxFit.contain,
                    ),
                  ),

                // العنوان في المركز
                if (title != null)
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      // alignment:
                      //     centerTitle ? Alignment.center : Alignment.centerLeft,
                      child: AppTextStyles(
                        title: title!,
                        // mediumSize: true,
                      ),
                    ),
                  ),

                // عرض العناصر على اليمين مع تفعيل حدث الضغط
                if (rightImages != null && rightImages!.isNotEmpty)
                  Row(
                    children: List.generate(rightImages!.length, (index) {
                      return GestureDetector(
                        onTap:
                            onPressEvents != null &&
                                    onPressEvents!.length > index
                                ? onPressEvents![index]
                                : null,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: rightImages![index], // عرض العنصر مباشرةً
                        ),
                      );
                    }),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
