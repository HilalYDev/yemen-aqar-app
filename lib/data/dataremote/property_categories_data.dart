import 'package:yemen_aqar/ApiRoutes.dart';
import 'package:yemen_aqar/utils/class/crud.dart';

class PropertyCategoriesData {
  Crud crud;
  PropertyCategoriesData(this.crud);
  getData() async {
    var response = await crud.callApi(
      url: ApiRoutes.propCatIndex,
      method: 'GET',
    );
    return response.fold((l) => l, (r) => r);
  }

  getPropertyByCategory(String categoryId) async {
    var response = await crud.callApi(
      url: ApiRoutes.propCatShow,
      method: 'POST',
      data: {'id': categoryId},
    );
    return response.fold((l) => l, (r) => r);
  }
}
