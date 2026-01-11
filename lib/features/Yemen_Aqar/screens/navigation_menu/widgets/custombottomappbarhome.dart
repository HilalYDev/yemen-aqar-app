import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yemen_aqar/utils/constants/app_colors.dart';

import '../../../controller/navigation_controller.dart';
import 'custombuttonappbar.dart';

class CustomBottomAppBarHome extends StatelessWidget {
  const CustomBottomAppBarHome({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth =
        MediaQuery.of(context).size.width; // 🔹 الحصول على عرض الشاشة
    double buttonWidth =
        screenWidth * 0.1; // 🔹 ضبط حجم الأزرار بناءً على عرض الشاشة

    return GetBuilder<NavigationController>(
      builder: (controller) => BottomAppBar(
        color: AppColors.deepNavy,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,

        // ✅ استخدام `Padding` لتوفير مساحة بين الأزرار
        child: Padding(
          padding: EdgeInsets.zero,
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // توزيع العناصر بالتساوي
            children: [
              ...List.generate(controller.listPage.length + 1, ((index) {
                int i = index > 2 ? index - 1 : index;
                return index == 2
                    ? SizedBox(width: buttonWidth) // ✅ إضافة مساحة بدل `Spacer`
                    : Expanded(
                        // ✅ توسيع الأزرار بشكل متساوٍ
                        child: CustomButtonAppBar(
                          textbutton: controller.bottomappbar[i]['title'],
                          icondata: controller.bottomappbar[i]['icon'],
                          onPressed: () {
                            controller.changePage(i);
                          },
                          active: controller.currentpage == i,
                        ),
                      );
              })),
            ],
          ),
        ),
      ),
    );
  }
}
