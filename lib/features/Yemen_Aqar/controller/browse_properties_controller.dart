import 'package:get/get.dart';

import '../../../data/dataremote/property.dart';
import '../../../utils/class/statusrequest.dart';
import '../../../utils/functions/handingdatacontroller.dart';
import '../model/PropertyModel.dart';

class BrowsePropertiesController extends GetxController {
  /// Data Source
  PropertyData propertyData = PropertyData(Get.find());

  /// Data
  List<PropertyModel> properties = [];

  /// Status
  StatusRequest statusRequest = StatusRequest.none;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  /// جلب بيانات العقارات
  Future<void> getData() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await propertyData.getBrowseProperties();

    // print("================ BrowsePropertiesController $response");

    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        properties =
            (response['data'] as List)
                .map((item) => PropertyModel.fromJson(item))
                .toList();

        // ✅ لا توجد بيانات
        if (properties.isEmpty) {
          statusRequest = StatusRequest.noData;
        }
      } else {
        // ❌ فشل من السيرفر
        statusRequest = StatusRequest.failure;
      }
    }

    update();
  }
}
