import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/dataremote/search_data.dart';
import '../../../utils/class/statusrequest.dart';
import '../../../utils/functions/handingdatacontroller.dart';
import '../../../utils/popups/toast_utils.dart';
import '../model/PropertyModel.dart';

class SearchDataController extends GetxController {
  SearchData searchData = SearchData(Get.find());

  // ✅ تغيير نوع البيانات إلى PropertyModel
  List<PropertyModel> allProperties = [];
  List<PropertyModel> filteredProperties = [];
  List<PropertyModel> searchedProperties = [];

  StatusRequest? statusRequest = StatusRequest.none;
  final TextEditingController searchController = TextEditingController();

  // ✅ البحث عن عقارات
  Future<void> getSearchData() async {
    try {
      if (searchController.text.trim().isEmpty) {
        ToastUtils.showToast(msg: "يرجى إدخال نص للبحث!");
        return;
      }

      statusRequest = StatusRequest.loading;
      update();

      var response = await searchData.searchProperties(searchController.text);
      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        if (response['status'] == "success" && response['data'].isNotEmpty) {
          searchedProperties =
              (response['data'] as List)
                  .map((item) => PropertyModel.fromJson(item))
                  .toList();
          filteredProperties = [];

          ToastUtils.showToast(
            msg: "تم العثور على ${searchedProperties.length} عقار",
          );
        } else {
          searchedProperties = [];
          statusRequest = StatusRequest.none;
          ToastUtils.showToast(msg: response['message'] ?? "لا توجد نتائج");
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

  // ✅ تصفية البيانات أثناء الكتابة (يمكنك تفعيلها إذا كان لديك قائمة أولية)
  void searchText(String query) {
    if (query.isEmpty) {
      filteredProperties = [];
    } else {
      filteredProperties =
          allProperties.where((property) {
            return (property.name != null &&
                    property.name!.toLowerCase().contains(
                      query.toLowerCase(),
                    )) ||
                (property.location != null &&
                    property.location!.toLowerCase().contains(
                      query.toLowerCase(),
                    ));
          }).toList();
    }
    update();
  }

  // ✅ تعبئة مربع البحث عند اختيار اقتراح
  void selectSuggestion(String name) {
    searchController.text = name;
    filteredProperties = [];
    update();
  }
}
