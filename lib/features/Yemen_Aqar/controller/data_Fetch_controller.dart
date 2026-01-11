// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:yemen_aqar/data/dataremote/fetch_data.dart';

import '../../../utils/class/statusrequest.dart';
import '../../../utils/functions/handingdatacontroller.dart';
import '../../../utils/popups/toast_utils.dart';
import '../model/PropertyCategoryModel.dart';

class DataFetchController extends GetxController {
  FetchAllData fetchAllData = FetchAllData(Get.find());
  // MyServices myServices = Get.find();

  List<PropertyCategoryModel> data = [];

  late StatusRequest statusRequest;

  Future<void> fetchDataType() async {
    try {
      statusRequest = StatusRequest.loading;
      // await Future.delayed(const Duration(seconds: 5));
      update();

      var response = await fetchAllData.fetchDataType();
      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        if (response['status'] == "success" && response['data'].isNotEmpty) {
          data =
              (response['data'] as List)
                  .map((item) => PropertyCategoryModel.fromJson(item))
                  .toList();
        } else {
          statusRequest = StatusRequest.none;
          ToastUtils.showToast(msg: response['message']);
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
    } catch (e) {
      statusRequest = StatusRequest.failure;

      ToastUtils.showToast(msg: "حدث خطأ غير متوقع: ${e.toString()}");
    }
    update();
  }

  @override
  void onInit() {
    fetchDataType();

    super.onInit();
  }
}
