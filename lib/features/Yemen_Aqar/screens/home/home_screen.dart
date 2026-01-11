// تعديل HomeScreen لتصبح PropertyBrowseScreen
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appBar/custom_app_bar.dart';
import '../../../../property_browse_screen.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/imgaeasset.dart';
import '../search/search_screen.dart';
import '../property_category/property_category_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // الحصول على بيانات المستخدم الحالي
    // الحصول على البيانات من الarguments
    final bool showBrowse = Get.arguments?['showBrowse'] ?? true;

    return Scaffold(
      appBar: CustomAppBar(
        color: AppColors.apparcolor,
        showLogo: true,
        // title: "الصفحة الرئيسية",
        // showBackButton: true,
        rightImages: [
          Image.asset(AppImageAsset.notifications),

          const Icon(
            Iconsax.search_normal,
            size: 25,
            color: AppColors.deepNavy,
          ),
        ],
        onPressEvents: [
          () {},
          () {
            Get.to(() => const SearchScreen());
          },
        ],
      ),
      body:
          showBrowse
              ? const BrowsePropertiesScreen()
              : SingleChildScrollView(
                child: Column(
                  children: [
                    // CustomShimmerWidget(),
                    PropertyCategoryScreen(),
                  ],
                ),
              ),
    );
  }
}
