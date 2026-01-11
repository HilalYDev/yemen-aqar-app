// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../constants/app_colors.dart';

// Future<bool> alertExitApp() {
//   Get.defaultDialog(
//       title: "تنبيه",
//       titleStyle: const TextStyle(
//           color: AppColors.deepNavy, fontWeight: FontWeight.bold),
//       middleText: "هل تريد الخروج من التطبيق",
//       actions: [
//         ElevatedButton(
//             style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all(AppColors.deepNavy)),
//             onPressed: () {
//               exit(0);
//             },
//             child: const Text("تاكيد")),
//         ElevatedButton(
//             style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all(AppColors.deepNavy)),
//             onPressed: () {
//               Get.back();
//             },
//             child: const Text("الغاء"))
//       ]);
//   return Future.value(true);
// }
