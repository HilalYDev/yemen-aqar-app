// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:yemen_aqar/ApiRoutes.dart';
import 'package:yemen_aqar/utils/class/crud.dart';

class AuthData {
  Crud crud = Crud();

  Future<dynamic> getUserData(String usersid, String phone) async {
    var response = await crud.callApi(
      url: ApiRoutes.getUserData,
      method: 'POST',
      data: {
        "id": usersid,
        "phone": phone,
      },
    );

    return response.fold((l) => l, (r) => r);
  }
}
// class AuthData {
//   Crud crud;
//   AuthData(this.crud);

  // getUserData(String usersid, String phone) async {
  //   var response =
  //       await crud.callApi(url: ApiRoutes.getUserData, method: 'POST', data: {
  //     "id": usersid,
  //     "phone": phone,
  //   });

  //   return response.fold((l) => l, (r) => r);
  // }
// }
