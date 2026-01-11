// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/dataremote/property.dart';
import '../../../../utils/class/statusrequest.dart';
import '../../../../utils/functions/handingdatacontroller.dart';
import '../../../../utils/popups/toast_utils.dart';
import '../../model/PropertyModel.dart';

class PropertyController extends GetxController {
  PropertyData propertyData = PropertyData(Get.find());

  List<PropertyModel> property = [];
  StatusRequest statusRequest = StatusRequest.none;

  int currentPage = 1;
  bool isLoadingMore = false;
  bool hasMore = true;

  String? id;
  String? type;
  String? name;

  @override
  void onInit() {
    id = Get.arguments['id']; // معرف نوع العقار أو المكتب
    type = Get.arguments['type']; // نوع الطلب
    name = Get.arguments['name']; // نوع الطلب
    getData();
    super.onInit();
  }

  Future<void> getData() async {
    // منع التحميل إذا انتهت البيانات أو جاري التحميل
    if (!hasMore || isLoadingMore) return;

    // تحديد حالة التحميل
    isLoadingMore = currentPage > 1;
    statusRequest = currentPage == 1 ? StatusRequest.loading : statusRequest;
    update();

    // جلب البيانات من السيرفر حسب النوع
    var response;
    if (type == "property_type") {
      // استدعاء الدالة العامة getPropertyByType فقط
      response = await propertyData.getPropertyByType(id!, currentPage);
      // print("=============================== getPropertyByType $response ");
    } else {
      debugPrint("❌ نوع غير مدعوم: $type");
      statusRequest = StatusRequest.failure;
      update();
      return;
    }

    // التعامل مع حالة الرد
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success &&
        response['status'] == "success") {
      var newProperties =
          (response['data'] as List)
              .map((item) => PropertyModel.fromJson(item))
              .toList();
      property.addAll(newProperties);
      currentPage++;

      // تحديث حالة hasMore
      hasMore = newProperties.length == 5; // عدد العناصر المتوقع لكل صفحة
    } else {
      hasMore = false; // لا توجد بيانات إضافية
      statusRequest = StatusRequest.failure;
    }

    isLoadingMore = false;
    update();
  }

  // دالة لتحميل المزيد من البيانات
  void loadMore() {
    getData(); // استدعاء الدالة الرئيسية
    // property.clear();
  }

  Future<void> deleteProperty(String propertyId) async {
    var response = await propertyData.deleteProperty(propertyId);
    property.removeWhere((element) => element.id.toString() == propertyId);
    _showErrorMessage(response['message']);
    update();
  }

  void _showErrorMessage(String message) {
    ToastUtils.showToast(msg: message);
    statusRequest = StatusRequest.none;
    update();
  }

  void addNewProperty(PropertyModel newProperty) {
    property.add(newProperty);
    statusRequest = StatusRequest.success; // إضافة هذا السطر

    update();
  }

  void updatePropertyInList(PropertyModel updatedProperty) {
    final index = property.indexWhere((a) => a.id == updatedProperty.id);
    if (index != -1) {
      property[index] = updatedProperty;
      update();
    }
  }
}
