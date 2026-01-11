// import 'package:yemen_aqar/ApiRoutes.dart';
// import 'package:yemen_aqar/utils/class/crud.dart';

// class OfficeData {
//   Crud crud;
//   OfficeData(this.crud);
//   getData(int page) async {
//     var response = await crud.callApi(
//       url: "${ApiRoutes.officeDetailIndex}?page=$page", // تمرير رقم الصفحة
//       method: 'GET',
//     );
//     return response.fold((l) => l, (r) => r);
//   }
//   // getData() async {
//   //   var response = await crud.callApi(
//   //     url: ApiRoutes.officeDetailIndex,
//   //     method: 'GET',
//   //   );
//   //   return response.fold((l) => l, (r) => r);
//   // }

//   getOfficeByUserId(String userId) async {
//     var response = await crud.callApi(
//       url: ApiRoutes.officeDetailShow,
//       method: 'POST',
//       data: {'user_id': userId},
//     );
//     return response.fold((l) => l, (r) => r);
//   }

//   getPropertiesByOfficeId(String id, int page) async {
//     var response = await crud.callApi(
//       url: ApiRoutes.officeDetailProperties,
//       method: 'POST',
//       data: {'id': id, 'page': page},
//     );
//     return response.fold((l) => l, (r) => r);
//   }
// }
