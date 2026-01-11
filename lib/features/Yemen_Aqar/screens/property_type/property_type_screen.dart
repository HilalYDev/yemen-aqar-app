import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yemen_aqar/common/widgets/shimmer/reusable_list_shimmer.dart';

import '../../../../common/widgets/appBar/custom_app_bar.dart';
import '../../../../common/widgets/custom_carousel_slider/custom_carousel_slider.dart';
import '../../../../common/widgets/reusable_list/reusable_list.dart';
import '../../../../utils/class/handlingdataview.dart';

import '../../../../utils/constants/imgaeasset.dart';
import '../../controller/property_type_controller .dart';
import '../../model/PropertyCategoryModel.dart';

class PropertyTypeScreen extends StatelessWidget {
  const PropertyTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PropertyTypeController());
    final PropertyTypeController controller = Get.find();
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomAppBar(
        title: controller.categoryName,
        showBackButton: true,

        // color: AppColor.white,
      ),
      body: GetBuilder<PropertyTypeController>(
        builder: (controller) {
          return HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widgetLoading: const ReusableListShimmer(),
            widget: SingleChildScrollView(
              child: Column(
                children: [
                  CustomCarouselSlider(
                    imageList: propertiesForSale,
                    autoPlay: true,

                    // aspectRatio: 16 / 9,
                    height: screenHeight * 0.22,
                    scrollDirection: Axis.horizontal,
                  ),
                  const SizedBox(height: 40),
                  ReusableCategoryList<PropertyCategoryModel>(
                    items: controller.categories,
                    onItemTap: (category) {
                      Get.toNamed(
                        '/PropertyScreen',
                        arguments: {
                          "id": category.id.toString(),
                          "type": "property_type",
                          "name": category.name.toString(),
                        },
                      );
                    },
                    getName: (category) => category.name ?? "غير معروف",
                    getImageUrl: (category) => category.image ?? '',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
