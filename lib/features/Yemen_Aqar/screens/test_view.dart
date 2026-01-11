// import 'package:flutter/material.dart';
// import 'package:yemen_aqar/utils/shared_preferences/user_preferences.dart';
// import '../../../common/widgets/appBar/custom_app_bar.dart';
// import '../../../utils/constants/app_colors.dart';

// class TestView extends StatelessWidget {
//   const TestView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Get.put(TestController());
//     return Scaffold(
//         appBar: const CustomAppBar(
//           title: "منتهي",
//           color: AppColors.apparcolor,
//         ),
//         body: Center(
//           child: Column(
//             children: [
//               const Text("الحساب منتهي"),
//               MaterialButton(
//                 onPressed: () {
//                   UserPreferences.clearUserData();
//                   // Get.offAll(() => const AuthScreen());
//                 },
//                 child: const Text("تسجيل خروج"),
//               )
//             ],
//           ),
//         )
//         // body: GetBuilder<TestController>(builder: (controller) {
//         //   if (controller.isLoading) {
//         //     return const Center(child: CircularProgressIndicator());
//         //   } else if (controller.errorMessage.isNotEmpty) {
//         //     return Center(
//         //       child: Column(
//         //         mainAxisAlignment: MainAxisAlignment.center,
//         //         children: [
//         //           Text(
//         //             controller.errorMessage,
//         //             style: const TextStyle(fontSize: 18, color: Colors.red),
//         //           ),
//         //           const SizedBox(height: 10),
//         //           ElevatedButton(
//         //             onPressed: () {
//         //               controller.getData(); // إعادة المحاولة
//         //             },
//         //             child: const Text('Retry'),
//         //           ),
//         //         ],
//         //       ),
//         //     );
//         //   } else if (controller.data.isEmpty) {
//         //     return const Center(child: Text('No data available'));
//         //   } else {
//         //     return ListView.builder(
//         //       itemCount: controller.data.length,
//         //       itemBuilder: (context, index) {
//         //         var item = controller.data[index];
//         //         return ListTile(
//         //           title: Text(item.name!),
//         //           subtitle: Text(item.name!),
//         //         );
//         //       },
//         //     );
//         //   }
//         // }),
//         );
//   }
// }
