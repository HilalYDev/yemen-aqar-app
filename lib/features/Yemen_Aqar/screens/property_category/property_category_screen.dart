import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:yemen_aqar/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:yemen_aqar/common/widgets/images/rounded_images.dart';
import 'package:yemen_aqar/common/widgets/shimmer/reusable_list_shimmer.dart';
import 'package:yemen_aqar/features/Yemen_Aqar/screens/property_type/property_type_screen.dart';
import 'package:yemen_aqar/utils/class/handlingdataview.dart';
import 'package:yemen_aqar/utils/constants/imgaeasset.dart';

import '../../../../common/widgets/reusable_list/reusable_list.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../controller/property_category_controller.dart';
import '../../model/PropertyCategoryModel.dart';

class PropertyCategoryScreen extends StatelessWidget {
  const PropertyCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PropertyCategoryController());
    double screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    //           bool isMyProperty =
    // UserPreferences.isPropertyOwner &&
    //  UserPreferences.id == UserPreferences.id;

    return GetBuilder<PropertyCategoryController>(
      builder: (controller) {
        return HandlingDataRequest(
          statusRequest: controller.statusRequest,
          widgetLoading: const ReusableListShimmer(),

          widget: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.1,
                  right: screenWidth * 0.1,
                  top: 21,
                ),
                child: RoundedContainer(
                  height: screenHeight * 0.17,
                  width: screenWidth,
                  backgroundColor: AppColors.apparcolor,
                  // padding: EdgeInsets.all(10),
                  showShadow: true,
                  child: const RoundedImage(
                    imageUrl: AppImageAsset.logoH,
                    fit: BoxFit.contain,
                    padding: EdgeInsets.all(10),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              const SizedBox(height: 40),
              ReusableCategoryList<PropertyCategoryModel>(
                items: controller.categories,
                onItemTap: (category) {
                  Get.to(
                    () => const PropertyTypeScreen(),
                    arguments: {
                      "categoryid": category.id.toString(),
                      "categoryName": category.name.toString(),
                    },
                  );
                },
                getName:
                    (category) =>
                        category.name.toString(), // ✅ دالة لاستخراج الاسم
                getImageUrl: (category) => category.image ?? '',
              ),
            ],
          ),
        );
      },
    );
  }
}
