import 'package:yemen_aqar/ApiRoutes.dart';
import 'package:yemen_aqar/utils/class/crud.dart';

class SearchData {
  Crud crud;
  SearchData(this.crud);
  // getData() async {
  //   var response = await crud.callApi(
  //     url: ApiRoutes.officeDetailIndex,
  //     method: 'GET',
  //   );
  //   return response.fold((l) => l, (r) => r);
  // }

  searchProperties(String searchKeyword) async {
    var response = await crud.callApi(
      url: ApiRoutes.search,
      method: 'POST',
      data: {'search_keyword': searchKeyword},
    );
    return response.fold((l) => l, (r) => r);
  }

  // ✅ البحث المتقدم (اختياري)
  advancedSearch({
    String? keyword,
    String? propertyTypeId,
    String? location,
    String? minPrice,
    String? maxPrice,
    String? currency,
  }) async {
    Map<String, dynamic> data = {};

    if (keyword != null) data['search_keyword'] = keyword;
    if (propertyTypeId != null) data['property_type_id'] = propertyTypeId;
    if (location != null) data['location'] = location;
    if (minPrice != null) data['min_price'] = minPrice;
    if (maxPrice != null) data['max_price'] = maxPrice;
    if (currency != null) data['currency'] = currency;

    var response = await crud.callApi(
      url: ApiRoutes.search,
      method: 'POST',
      data: data,
    );
    return response.fold((l) => l, (r) => r);
  }
}
