import '../../../ApiRoutes.dart';
import '../../../utils/class/crud.dart';

class VerfiyCodeData {
  Crud crud;
  VerfiyCodeData(this.crud);

  verifyPhone(String phone, String verifycode) async {
    var response = await crud.callApi(
        url: ApiRoutes.verifyPhone,
        method: 'POST',
        data: {'phone': phone, "verification_code": verifycode});
    return response.fold((l) => l, (r) => r);
  }

  resendVerifyCode(String phone) async {
    var response = await crud.callApi(
        url: ApiRoutes.resendVerificationCode,
        method: 'POST',
        data: {'phone': phone});
    return response.fold((l) => l, (r) => r);
  }
}
