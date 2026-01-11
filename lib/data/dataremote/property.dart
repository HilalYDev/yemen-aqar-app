import 'dart:io';

import 'package:yemen_aqar/ApiRoutes.dart';
import 'package:yemen_aqar/utils/class/crud.dart';

class PropertyData {
  Crud crud;
  PropertyData(this.crud);
  getBrowseProperties() async {
    var response = await crud.callApi(
      url: ApiRoutes.propertyIndex,
      method: 'GET',
    );
    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> getPropertyByType(String id, int page) async {
    return (await crud.callApi(
      url: ApiRoutes.propTypeShow,
      method: 'POST',
      data: {'id': id, 'page': page},
    )).fold((l) => l, (r) => r);
  }

  // getPropertiesByOfficeId(String id, int page) async {
  //   var response = await crud.callApi(
  //     url: ApiRoutes.officeDetailProperties,
  //     method: 'POST',
  //     data: {'id': id, 'page': page},
  //   );
  //   return response.fold((l) => l, (r) => r);
  // }

  // getPropertyByTypeOffice(
  //   String userId,
  //   String propertyTypeId,
  //   int page,
  // ) async {
  //   var response = await crud.callApi(
  //     url: ApiRoutes.propertyShow,
  //     method: 'POST',
  //     data: {
  //       'user_id': userId,
  //       'property_type_id': propertyTypeId,
  //       'page': page,
  //     },
  //   );
  //   return response.fold((l) => l, (r) => r);
  // }

  //  addProperty(   String name,
  //  String description,
  //  String image,
  //  String price,
  //  String location,
  //  String propertyTypeId,
  //  String userId,) async {
  //   var response = await crud.callApi(ApiRoutes.propertyStore, method: 'POST',     data: {
  //     'name': name,
  //     'description': description,
  //     'image': image,
  //     'price': price,
  //     'location': location,
  //     'property_type_id': propertyTypeId,
  //     'user_id': userId,
  //   },);
  //   return response.fold((l) => l, (r) => r);
  // }
  addProperty(
    String name,
    String description,
    File image,
    File ownershipImage, // ✅ إضافة متغير صورة الملكية
    String price,
    String selectedCurrency,
    String location,
    String propertyTypeId,
    String userId,
  ) async {
    var response = await crud.callApi(
      url: ApiRoutes.propertyStore,
      method: 'POST',
      data: {
        'name': name,
        'description': description,
        // 'image': image,
        'price': price,
        'currency': selectedCurrency,
        'location': location,
        'property_type_id': propertyTypeId,
        'user_id': userId,
      },
      singleFile: image, // إضافة ملف الصورة
      singleFileField: 'image',
      secondFile: ownershipImage, // ✅ إضافة صورة الملكية
      secondFileField: 'ownership_image', // ✅ إضافة حقل صورة الملكية
    );
    return response.fold((l) => l, (r) => r);
  }

  updateProperty(
    String propertyId,
    String name,
    String description,
    File? image, // صورة العقار (اختيارية)
    File? ownershipImage, // ✅ صورة الملكية (اختيارية)
    String price,
    String selectedCurrency,
    String location,
    String propertyTypeId,
    String userId,
  ) async {
    var data = {
      'id': propertyId,
      'name': name,
      'description': description,
      'price': price,
      'currency': selectedCurrency,
      'location': location,
      'property_type_id': propertyTypeId,
      'user_id': userId,
    };

    // ✅ الحالة 1: إذا كان هناك صورة عقار وصورة ملكية
    if (image != null && ownershipImage != null) {
      var response = await crud.callApi(
        url: ApiRoutes.propertyUpdate,
        method: 'POST',
        data: data,
        singleFile: image,
        singleFileField: 'image',
        secondFile: ownershipImage, // ✅ إضافة صورة الملكية
        secondFileField: 'ownership_image',
      );
      return response.fold((l) => l, (r) => r);
    }
    // ✅ الحالة 2: إذا كان هناك صورة عقار فقط
    else if (image != null) {
      var response = await crud.callApi(
        url: ApiRoutes.propertyUpdate,
        method: 'POST',
        data: data,
        singleFile: image,
        singleFileField: 'image',
      );
      return response.fold((l) => l, (r) => r);
    }
    // ✅ الحالة 3: إذا كان هناك صورة ملكية فقط
    else if (ownershipImage != null) {
      var response = await crud.callApi(
        url: ApiRoutes.propertyUpdate,
        method: 'POST',
        data: data,
        singleFile: ownershipImage,
        singleFileField: 'ownership_image',
      );
      return response.fold((l) => l, (r) => r);
    }
    // ✅ الحالة 4: لا توجد صور (تحديث البيانات فقط)
    else {
      var response = await crud.callApi(
        url: ApiRoutes.propertyUpdate,
        method: 'POST',
        data: data,
      );
      return response.fold((l) => l, (r) => r);
    }
  }

  deleteProperty(String propertyId) async {
    var response = await crud.callApi(
      url: ApiRoutes.propertyDelete,
      method: 'POST',
      data: {'id': propertyId},
    );
    return response.fold((l) => l, (r) => r);
  }
}
