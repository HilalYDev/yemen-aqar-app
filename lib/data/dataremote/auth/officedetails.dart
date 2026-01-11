

import '../../../ApiRoutes.dart';
import '../../../utils/class/crud.dart';

class OfficeDetailsData {
  Crud crud;
  OfficeDetailsData(this.crud);

register(String username, String idNumber, String phoneNumber, String commercialRegister, String password, String type, String token) async {
  // تجهيز البيانات لإرسالها إلى الـ API
  var data = {
    'username': username,
    'id_number': idNumber,
    'phone_number': phoneNumber,
    'commercial_register': commercialRegister,
    'password': password,
    'type': type,
    'token': token, // إذا كنت بحاجة إلى إضافة التوكن
  };

  // إجراء الاتصال بالـ API باستخدام الدالة callApi
  var response = await crud.callApi(url:
    ApiRoutes.userregister, // رابط الـ API الخاص بالتسجيل
    method: 'POST',
    data: data, // البيانات التي سيتم إرسالها
  );

  // إرجاع الاستجابة بناءً على النتيجة
  return response.fold((l) => l, (r) => r);
}}