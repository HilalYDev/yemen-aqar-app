// ignore_for_file: avoid_print

import 'package:get/get.dart';

import '../../../data/dataremote/property_categories_data.dart';
import '../../../utils/class/statusrequest.dart';
import '../../../utils/functions/handingdatacontroller.dart';
import '../../../utils/services/my_services.dart';
import '../../../utils/shared_preferences/user_preferences.dart';
import '../model/PropertyCategoryModel.dart';

class HomeScreenController extends GetxController {
  PropertyCategoriesData propertyCategoriesData = PropertyCategoriesData(
    Get.find(),
  );

  List<PropertyCategoryModel> categories = [];

  late StatusRequest statusRequest;
  MyServices myServices = Get.find();

  // String?id, username,type;
  String userId = UserPreferences.id;
  String username = UserPreferences.username;
  String userType = UserPreferences.userType;
  getData() async {
    statusRequest = StatusRequest.loading;
    // await Future.delayed(const Duration(seconds: 5));
    var response = await propertyCategoriesData.getData();
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // categories.addAll(response['data']);
      categories = (response['data'] as List)
          .map((item) => PropertyCategoryModel.fromJson(item))
          .toList();
    }
    update();
  }

  @override
  void onInit() {
    // getData();
    // initialData() ;
    super.onInit();
  }

  void initialData() {
    // lang = myServices.sharedPreferences.getString("lang");
    //      id = myServices.sharedPreferences.getString("id");
    //     username = myServices.sharedPreferences.getString("username");

    // type = myServices.sharedPreferences.getString("type");
  }
}
