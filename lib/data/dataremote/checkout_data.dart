import '../../ApiRoutes.dart';
import '../../utils/class/crud.dart';

class CheckoutData {
  Crud crud;
  CheckoutData(this.crud);

  Future<dynamic> checkout(String userId) async {
    var response = await crud.callApi(
      url: ApiRoutes.orderCheckout, // رابط إضافة عنصر للسلة
      method: 'POST',
      data: {'user_id': userId},
    );
    return response.fold((l) => l, (r) => r);
  }
}
