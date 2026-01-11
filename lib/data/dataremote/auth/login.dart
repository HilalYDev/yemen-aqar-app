import '../../../ApiRoutes.dart';
import '../../../utils/class/crud.dart';

class LoginData {
  Crud crud;
  LoginData(this.crud);
  login(String phone, String password, String token) async {
    var response = await crud.callApi(
      url: ApiRoutes.userlogin,
      method: 'POST',
      data: {"phone": phone, "password": password, "device_token": token},
    );

    return response.fold((l) => l, (r) => r);
  }
}
