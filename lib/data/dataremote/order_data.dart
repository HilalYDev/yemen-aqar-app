import 'package:yemen_aqar/ApiRoutes.dart';
import 'package:yemen_aqar/utils/class/crud.dart';

class OrderData {
  final Crud crud;
  OrderData(this.crud);

  /// جلب عناصر السلة من السيرفر
  Future<dynamic> userOrders(String userId) async {
    var response = await crud.callApi(
      url: ApiRoutes.orderUsers, // أنشئ رابط جلب السلة في ApiRoutes
      method: 'POST',
      data: {'user_id': userId},
    );
    return response.fold((l) => l, (r) => r);
  }
}
