// ignore_for_file: file_names

import 'package:get/get.dart';

import '../../../data/dataremote/property_categories_data.dart';
import '../../../utils/class/statusrequest.dart';
import '../../../utils/functions/handingdatacontroller.dart';
import '../model/PropertyCategoryModel.dart';

class PropertyTypeController extends GetxController {
  PropertyCategoriesData propertyCategoriesData = PropertyCategoriesData(
    Get.find(),
  );
  List<PropertyCategoryModel> categories = [];
  StatusRequest statusRequest = StatusRequest.none;
  late String categoryid;
  late String categoryName;
  @override
  void onInit() {
    final args = Get.arguments;
    categoryid = args["categoryid"];
    categoryName = args["categoryName"];
    getData();
    super.onInit();
  }

  Future<void> getData() async {
    statusRequest = StatusRequest.loading;
    // await Future.delayed(const Duration(seconds: 5));
    var response = await propertyCategoriesData.getPropertyByCategory(
      categoryid,
    );
    // ignore: avoid_print
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        // data.addAll(response['data']);
        categories =
            (response['data'] as List)
                .map((item) => PropertyCategoryModel.fromJson(item))
                .toList();
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }
}
