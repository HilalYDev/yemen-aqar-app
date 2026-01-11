import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yemen_aqar/common/widgets/reusable_list/reusable_list.dart';
import 'package:yemen_aqar/common/widgets/shimmer/reusable_list_shimmer.dart';
import 'package:yemen_aqar/features/Yemen_Aqar/model/PropertyCategoryModel.dart';
import 'package:yemen_aqar/utils/constants/app_colors.dart';

import '../../../../../common/widgets/appBar/custom_app_bar.dart';
import '../../../../../common/widgets/custom_carousel_slider/custom_carousel_slider.dart';
import '../../../../../utils/class/handlingdataview.dart';
import '../../../../../utils/constants/imgaeasset.dart';
import '../../../controller/data_Fetch_controller.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DataFetchController());
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const CustomAppBar(
        title: "جميع الاقسام",
        color: AppColors.apparcolor,
      ),

      body: SingleChildScrollView(
        child: GetBuilder<DataFetchController>(
          builder: (controller) {
            return HandlingDataRequest(
              statusRequest: controller.statusRequest,
              widgetLoading: const ReusableListShimmer(),
              widget: Column(
                children: [
                  CustomCarouselSlider(
                    imageList: imgList,
                    autoPlay: true,
                    height: screenHeight * 0.22,
                    scrollDirection: Axis.horizontal,
                  ),
                  const SizedBox(height: 40),
                  ReusableCategoryList<PropertyCategoryModel>(
                    items: controller.data,
                    onItemTap: (category) {
                      Get.toNamed(
                        '/PropertyScreen',
                        arguments: {
                          "id": category.id.toString(),
                          "type": "property_type",
                        },
                      );
                    },
                    getName: (category) => category.name ?? "غير معروف",
                    getImageUrl: (category) => category.image ?? '',
                  ),
                ],
              ),
            );
          },
        ),
      ),
      // body: SingleChildScrollView(
      //   // ✅ إضافة شريط التمرير
      //   child: Column(
      //     children: [
      // CustomCarouselSlider(
      //   imageList: imgList,
      //   autoPlay: true,
      //   height: screenHeight * 0.22,
      //   scrollDirection: Axis.horizontal,
      // ),
      // const SizedBox(height: 40),

      //     ],
      //   ),
      // ),
    );
  }
}
