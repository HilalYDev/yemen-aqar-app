import '../../../ApiRoutes.dart';
import '../../../utils/class/crud.dart';

class ForgotPasswordData {
  Crud crud;
  ForgotPasswordData(this.crud);
  checkPhone(String phone) async {
    var response =
        await crud.callApi(url: ApiRoutes.checkPhone, method: 'POST', data: {
      'phone': phone,
    });
    return response.fold((l) => l, (r) => r);
  }

  resetPassword(String phone, String password) async {
    var response = await crud.callApi(
        url: ApiRoutes.resetPassword,
        method: 'POST',
        data: {'phone': phone, "password": password});
    return response.fold((l) => l, (r) => r);
  }
}
