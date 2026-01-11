// import 'package:flutter/material.dart';
// import 'package:yemen_aqar/common/widgets/appBar/custom_app_bar.dart';
// import 'package:yemen_aqar/utils/shared_preferences/user_preferences.dart';

// class TestScreens extends StatelessWidget {
//   const TestScreens({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: const CustomAppBar(
//           title: "الحساب غير مفعل",
//         ),
//         body: Center(
//           child: Column(
//             children: [
//               const Text("الحساب غير مفعل"),
//               MaterialButton(
//                 onPressed: () {
//                   UserPreferences.clearUserData();
//                   // Get.offAll(() => const AuthScreen());
//                 },
//                 child: const Text("تسجيل خروج"),
//               )
//             ],
//           ),
//         ));
//   }
// }
