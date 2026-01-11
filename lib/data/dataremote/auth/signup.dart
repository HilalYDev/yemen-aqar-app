// import 'dart:io';

import '../../../ApiRoutes.dart';
import '../../../utils/class/crud.dart';

class SignupData {
  Crud crud;
  SignupData(this.crud);

  register(
    String name,
    String phoneNumber,
    String password,
    String type,
    String token,
  ) async {
    // تجهيز البيانات لإرسالها إلى الـ API
    var data = {
      'name': name,
      'phone': phoneNumber,
      'password': password,
      'type': type,
      'token': token, // إذا كنت بحاجة إلى إضافة التوكن
    };

    // إجراء الاتصال بالـ API باستخدام الدالة callApi
    var response = await crud.callApi(
      url: ApiRoutes.userregister, // رابط الـ API الخاص بالتسجيل
      method: 'POST',
      data: data, // البيانات التي سيتم إرسالها
    );

    // إرجاع الاستجابة بناءً على النتيجة
    return response.fold((l) => l, (r) => r);
  }

  // registerOffice(
  //   String name,
  //   String phoneNumber,
  //   String password,
  //   String type,
  //   String token,
  //   String officeName,
  //   String identityNumber,
  //   File image,
  //   String officeAddress,
  //   String officePhone,
  // ) async {
  //   // تجهيز البيانات لإرسالها إلى الـ API
  //   var data = {
  //     'name': name,
  //     'phone': phoneNumber,
  //     'password': password,
  //     'type': type,
  //     'token': token, // إذا كنت بحاجة إلى إضافة التوكن

  //     "office_name": officeName,
  //     "identity_number": identityNumber,
  //     // "commercial_register_image": commercialRegisterImage,
  //     "office_address": officeAddress,
  //     "office_phone": officePhone,
  //   };

  //   // إجراء الاتصال بالـ API باستخدام الدالة callApi
  //   var response = await crud.callApi(
  //     url: ApiRoutes.userregister, // رابط الـ API الخاص بالتسجيل
  //     method: 'POST',
  //     data: data,
  //     singleFile: image, // إضافة ملف الصورة
  //     singleFileField: 'image', // البيانات التي سيتم إرسالها
  //   );

  //   // إرجاع الاستجابة بناءً على النتيجة
  //   return response.fold((l) => l, (r) => r);
  // }
}
