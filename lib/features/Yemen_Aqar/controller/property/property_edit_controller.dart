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
import 'property_controller.dart';
import '../../model/PropertyModel.dart';

class PropertyEditController extends GetxController {
  PropertyData propertyData = PropertyData(Get.find());
  final GlobalKey<FormState> formStateProperty = GlobalKey<FormState>();
  StatusRequest? statusRequest = StatusRequest.none;

  final name = TextEditingController();
  final description = TextEditingController();
  final price = TextEditingController();
  final location = TextEditingController();

  File? thumbnail; // صورة العقار
  File? ownershipImage; // ✅ صورة الملكية
  String? propertyTypeId;
  String? propertyId;
  PropertyModel? propertyModel;
  late String imageUrl;
  late String ownershipImageUrl; // ✅ رابط صورة الملكية

  /// ✅ قائمة العملات المتاحة
  final List<String> currencies = ["دولار", "ريال سعودي", "ريال يمني"];
  String? selectedCurrency;

  /// ✅ دالة لتحديث العملة
  void updateCurrency(String currency) {
    selectedCurrency = currency;
    debugPrint("================================$selectedCurrency");
    update();
  }

  /// ✅ دالة لاختيار صورة العقار
  Future<void> chooseThumbnail() async {
    thumbnail = await pickSingleImageFromGallery();
    update();
  }

  /// ✅ دالة لاختيار صورة الملكية
  Future<void> chooseOwnershipImage() async {
    ownershipImage = await pickSingleImageFromGallery();
    update();
  }

  Future<void> updateProperty() async {
    String priceWithoutCommas = Formatter.removeCommas(price.text);

    if (formStateProperty.currentState!.validate()) {
      // ✅ التحقق من أن العقار غير مباع
      // if (propertyModel?.isSold == true) {
      //   Get.snackbar(
      //     "خطأ",
      //     "لا يمكن تعديل عقار تم بيعه",
      //     backgroundColor: Colors.red,
      //     colorText: Colors.white,
      //   );
      //   return;
      // }

      statusRequest = StatusRequest.loading;
      update();

      var response = await propertyData.updateProperty(
        propertyModel!.id.toString(),
        name.text,
        description.text,
        thumbnail, // صورة العقار (قد تكون null)
        ownershipImage, // ✅ صورة الملكية (قد تكون null)
        priceWithoutCommas,
        selectedCurrency!,
        location.text,
        propertyTypeId!,
        UserPreferences.id,
      );

      statusRequest = handlingData(response);

      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          _showSuccessMessage(response['message']);

          // ✅ معالجة البيانات المرجعة
          final updatedProperty = PropertyModel.fromJson(
            response['property'] ?? response['data'],
          );

          // ✅ تحديث الـ Controller الرئيسي
          final propertyController = Get.find<PropertyController>();
          propertyController.updatePropertyInList(updatedProperty);

          Get.back();
        } else {
          _showErrorMessage(response['message'] ?? "فشل في التعديل");
        }
      } else {
        _showErrorMessage("حدث خطأ أثناء التعديل");
      }
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    propertyModel = Get.arguments['property'];
    setInitialValues();
  }

  void setInitialValues() {
    try {
      // حقول النصوص
      propertyId = propertyModel!.id.toString();
      name.text = propertyModel!.name ?? '';
      description.text = propertyModel!.description ?? '';
      imageUrl = propertyModel!.image ?? '';
      price.text = propertyModel!.price ?? '';
      selectedCurrency = propertyModel!.currency ?? currencies.first;
      location.text = propertyModel!.location ?? '';
      propertyTypeId = propertyModel!.propertyTypeId?.toString() ?? '';

      // ✅ رابط صورة الملكية
      ownershipImageUrl = propertyModel!.ownershipImage ?? '';
    } catch (e) {
      debugPrint("Error setting initial values: $e");
      Get.snackbar("خطأ", "خطأ أثناء تعيين القيم الأولية");
    }
  }

  /// ✅ دالة لعرض رسالة نجاح
  void _showSuccessMessage(String message) {
    ToastUtils.showToast(msg: message);
    statusRequest = StatusRequest.success;
  }

  /// ✅ دالة لعرض رسالة خطأ
  void _showErrorMessage(String message) {
    ToastUtils.showToast(msg: message);
    statusRequest = StatusRequest.failure;
  }

  @override
  void onClose() {
    name.dispose();
    description.dispose();
    price.dispose();
    location.dispose();
    super.onClose();
  }
}
