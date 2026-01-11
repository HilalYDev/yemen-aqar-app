import 'package:yemen_aqar/ApiRoutes.dart';
import 'package:yemen_aqar/utils/class/crud.dart';

class CartData {
  final Crud crud;
  CartData(this.crud);

  /// جلب عناصر السلة من السيرفر
  Future<dynamic> getData(String userId) async {
    var response = await crud.callApi(
      url: ApiRoutes.cartShow, // أنشئ رابط جلب السلة في ApiRoutes
      method: 'POST',
      data: {'user_id': userId},
    );
    return response.fold((l) => l, (r) => r);
  }

  /// إضافة عنصر للسلة على السيرفر
  Future<dynamic> addToCart(String userId, String propertyId) async {
    var response = await crud.callApi(
      url: ApiRoutes.cartStore, // رابط إضافة عنصر للسلة
      method: 'POST',
      data: {'user_id': userId, 'property_id': propertyId},
    );
    return response.fold((l) => l, (r) => r);
  }

  /// إزالة عنصر من السلة على السيرفر
  Future<dynamic> removeFromCart(String cartId, String userId) async {
    var response = await crud.callApi(
      url: ApiRoutes.cartDelete,
      method: 'POST',
      data: {'cart_id': cartId, 'user_id': userId},
    );
    return response.fold((l) => l, (r) => r);
  }

  /// الحصول على عدد العناصر في السلة (يمكن من السيرفر أو القائمة المحلية بعد الجلب)
  // Future<int> getCartCount(String userId) async {
  //   var items = await getCartItems(userId);
  //   if (items['status'] == 'success') {
  //     return (items['data'] as List).length;
  //   } else {
  //     return 0;
  //   }
  // }
}
