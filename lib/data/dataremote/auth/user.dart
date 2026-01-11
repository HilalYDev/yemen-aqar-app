// // ignore_for_file: prefer_typing_uninitialized_variables

// import 'package:image_picker/image_picker.dart';

// import '../../../../core/class/crud.dart';
// import '../../../../linkapi.dart';

// class Userdata {
//   Crud crud;
//   Userdata(this.crud);
//   getData(String usersid) async {
//     var response = await crud.postData(AppLink.users, {"id": usersid});
//     return response.fold((l) => l, (r) => r);
//   }

//   updateUser(Map data, [XFile? file]) async {
//     var response;
//     if (file == null) {
//       response = await crud.postData(AppLink.updateusers, data);
//     } else {
//       response =
//           await crud.addRequestWithImageOne(AppLink.updateusers, data, file);
//     }

//     return response.fold((l) => l, (r) => r);
//   }

//   // imgesusers(Map data, File file) async {
//   //   var response =
//   //       await crud.addRequestWithImageOne(AppLink.imgesusers, data, file);
//   //   return response.fold((l) => l, (r) => r);
//   // }

//   // editusers(Map data, [File? file]) async {
//   //   var response;
//   //   if (file == null) {
//   //     response = await crud.postData(AppLink.imgesusers, data);
//   //   } else {
//   //     response =
//   //         await crud.addRequestWithImageOne(AppLink.imgesusers, data, file);
//   //   }

//   //   return response.fold((l) => l, (r) => r);
//   // }
// }
