// ignore_for_file: file_names, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yemen_aqar/data/dataremote/property.dart';
import 'package:yemen_aqar/utils/functions/uplodimegs.dart';
import 'package:yemen_aqar/utils/popups/toast_utils.dart';
import 'package:yemen_aqar/utils/shared_preferences/user_preferences.dart';
import '../../../../utils/class/statusrequest.dart';
import '../../../../utils/formatters/formatter.dart';
import '../../../../utils/functions/handingdatacontroller.dart';
import '../../model/PropertyModel.dart';
import 'property_controller.dart';

class PropertyAddController extends GetxController {
  PropertyData propertyData = PropertyData(Get.find());
  final GlobalKey<FormState> formStateProperty = GlobalKey<FormState>();
  StatusRequest? statusRequest = StatusRequest.none;

  final name = TextEditingController();
  final description = TextEditingController();
  final image = TextEditingController();
  final price = TextEditingController();
  final location = TextEditingController();

  File? thumbnail; // صورة العقار
  File? ownershipImage; // ✅ صورة الملكية
  String? propertyTypeId;

  // ✅ قائمة العملات المتاحة
  final List<String> currencies = ["دولار", "ريال سعودي", "ريال يمني"];
  String? selectedCurrency;

  // ✅ دالة لتحديث العملة
  void updateCurrency(String currency) {
    selectedCurrency = currency;
    print("================================$selectedCurrency");
    update();
  }

  // ✅ دالة لاختيار صورة العقار
  Future<void> chooseThumbnail() async {
    thumbnail = await pickSingleImageFromGallery();
    update();
  }

  // ✅ دالة لاختيار صورة الملكية
  Future<void> chooseOwnershipImage() async {
    ownershipImage = await pickSingleImageFromGallery();
    update();
  }

  Future<void> addProperty() async {
    String priceWithoutCommas = Formatter.removeCommas(price.text);

    if (formStateProperty.currentState!.validate()) {
      if (thumbnail == null) {
        Get.snackbar("خطأ", "يجب اختيار صورة للعقار");
        return;
      }

      if (ownershipImage == null) {
        Get.snackbar("خطأ", "يجب اختيار صورة ملكية العقار");
        return;
      }

      statusRequest = StatusRequest.loading;
      update();

      var response = await propertyData.addProperty(
        name.text,
        description.text,
        thumbnail!, // صورة العقار
        ownershipImage!, // ✅ صورة الملكية
        priceWithoutCommas,
        selectedCurrency!,
        location.text,
        propertyTypeId!,
        UserPreferences.id,
      );

      print("=============================== Controller $response ");
      statusRequest = handlingData(response);

      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          _showSuccessMessage(response['message']);

          // ✅ معالجة البيانات المرجعة
          final newProperty = PropertyModel.fromJson(response['data']);

          // ✅ تحديث الـ Controller الرئيسي
          final propertyController = Get.find<PropertyController>();
          propertyController.addNewProperty(newProperty);

          Get.back();
        } else {
          _showErrorMessage(response['message']);
          statusRequest = StatusRequest.failure;
          update();
        }
      }
    }
  }

  void clearForm() {
    name.clear();
    description.clear();
    image.clear();
    price.clear();
    location.clear();
    thumbnail = null;
    ownershipImage = null; // ✅ تنظيف صورة الملكية
    selectedCurrency = null;
    update();
  }

  @override
  void onInit() {
    propertyTypeId = Get.arguments['propertyTypeId'];

    // ✅ تعيين قيم افتراضية للتجربة
    name.text = "اسم العقار اضافة";
    description.text = "تفاصيل العقار اضافة";
    price.text = "500";
    location.text = "موقع العقار اضافة";
    selectedCurrency = currencies.first; // ✅ تعيين عملة افتراضية

    super.onInit();
  }

  // ✅ دالة لعرض رسالة نجاح
  void _showSuccessMessage(String message) {
    ToastUtils.showToast(msg: message);
    statusRequest = StatusRequest.success;
  }

  // ✅ دالة لعرض رسالة خطأ
  void _showErrorMessage(String message) {
    ToastUtils.showToast(msg: message);
    statusRequest = StatusRequest.failure;
  }
}
