import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/dataremote/property_categories_data.dart';
import '../../../utils/class/statusrequest.dart';
import '../../../utils/functions/handingdatacontroller.dart';
import '../model/PropertyCategoryModel.dart';

class PropertyCategoryController extends GetxController {
  PropertyCategoriesData propertyCategoriesData = PropertyCategoriesData(
    Get.find(),
  );

  List<PropertyCategoryModel> categories = [];

  StatusRequest statusRequest = StatusRequest.none;
  @override
  void onInit() {
    getData();
    super.onInit();
  }

  Future<void> getData() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await propertyCategoriesData.getData();

    debugPrint("================ PropertyCategoryController $response");

    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        categories =
            (response['data'] as List)
                .map((item) => PropertyCategoryModel.fromJson(item))
                .toList();

        if (categories.isEmpty) {
          statusRequest = StatusRequest.noData; // ✅ تمييز لا توجد بيانات
        }
      } else {
        statusRequest = StatusRequest.failure; // ❌ فشل عام
      }
    }

    update();
  }
}
