import 'package:flutter/material.dart';
import 'package:reorderable_tabbar/reorderable_tabbar.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/imgaeasset.dart';
import '../custom_shapes/containers/primary_header_container.dart';

class AuthPage extends StatelessWidget {
  final int length; // عدد التبويبات
  final List<Tab> tabs; // قائمة التبويبات
  final List<Widget> tabViews; // قائمة المحتويات المرتبطة بالتبويبات

  const AuthPage({
    super.key,
    required this.length,
    required this.tabs,
    required this.tabViews,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            PrimaryHeaderContainer(
              child: Column(
                children: [
                  Container(
                    width: double.infinity, // لضمان عرض الحاوية بالكامل
                    color: AppColors.apparcolor,
                    height: size.height * 0.30, // ربع ارتفاع الشاشة
                    child: Image.asset(
                      AppImageAsset.logoH, // ضع هنا مسار الصورة
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -20),
              child: DefaultTabController(
                length: length,
                child: Column(
                  children: [
                    ReorderableTabBar(
                      isScrollable: true,
                      indicatorWeight: 5.0,
                      labelColor: AppColors.copperTan,
                      indicatorColor: AppColors.deepNavy,
                      tabBorderRadius: const BorderRadius.vertical(
                        top: Radius.circular(8),
                      ),
                      tabs: tabs,
                      labelStyle: const TextStyle(
                        fontFamily: "modern", // اسم الخط المحدد في pubspec.yaml
                        fontSize: 18,
                      ),
                    ),

                    // TabBarView لعرض المحتوى بناءً على التبويب المحدد
                    SizedBox(
                      height: size.height * 0.69,
                      child: TabBarView(children: tabViews),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
