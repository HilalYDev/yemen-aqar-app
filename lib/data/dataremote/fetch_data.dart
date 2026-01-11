import 'package:yemen_aqar/ApiRoutes.dart';
import 'package:yemen_aqar/utils/class/crud.dart';

class FetchAllData {
  Crud crud;
  FetchAllData(this.crud);
  fetchDataType() async {
    var response = await crud.callApi(
      url: ApiRoutes.propTypeIndex,
      method: 'GET',
    );
    return response.fold((l) => l, (r) => r);
  }

  getProductsByCategory(String categoryId) async {
    var response =
        await crud.callApi(url: ApiRoutes.propCatShow, method: 'POST', data: {
      'category_id': categoryId,
    });
    return response.fold((l) => l, (r) => r);
  }
}
