import 'package:yemen_aqar/utils/class/crud.dart';

import '../../ApiRoutes.dart';

class TestData {
  Crud crud;
  TestData(this.crud);

  Future<Map<String, dynamic>> getData() async {
    try {
      var response = await crud.callApiTest(
        url: ApiRoutes.propCatIndex,
        method: 'GET',
      );

      // إذا كان هناك خطأ في الاستجابة، نرجعه كـ Map
      if (response.containsKey('error') && response['error'] == true) {
        return {
          'error': true,
          'message': response['message'],
        };
      }

      // إذا لم يكن هناك خطأ، نرجع البيانات
      return response;
    } catch (e) {
      // في حالة حدوث استثناء، نرجع رسالة خطأ
      return {
        'error': true,
        'message': 'An error occurred: $e',
      };
    }
  }
}
