import 'package:get/get.dart';
import '../../../data/dataremote/test_data.dart';
import '../model/PropertyCategoryModel.dart';

class TestController extends GetxController {
  TestData testData = TestData(Get.find());

  List<PropertyCategoryModel> data = [];
  bool isLoading = true;
  String errorMessage = '';

  Future<void> getData() async {
    try {
      isLoading = true;
      errorMessage = '';
      update();

      Map<String, dynamic> response = await testData.getData();

      if (response.containsKey('error') && response['error'] == true) {
        // إذا كان هناك خطأ، نعرض الرسالة
        errorMessage = response['message'];
      } else if (response['status'] == "success") {
        // إذا لم يكن هناك خطأ، نعالج البيانات
        data = (response['data'] as List)
            .map((item) => PropertyCategoryModel.fromJson(item))
            .toList();
      } else {
        // إذا كانت البيانات غير متوقعة
        errorMessage = 'Unexpected response from server';
      }

      isLoading = false;
      update();
    } catch (e) {
      isLoading = false;
      errorMessage = 'Failed to load data. Please try again.';
      update();
    }
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
