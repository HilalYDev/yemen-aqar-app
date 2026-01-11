// ignore_for_file: file_names
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../../../common/widgets/appBar/custom_app_bar.dart';
// import '../../../../../utils/class/handlingdataview.dart';
// import '../../../../../utils/constants/color.dart';
// import '../../../controller/search_controller.dart'; // تأكد من استيراد الـ Controller الصحيح

// class SearchScreen extends StatelessWidget {
//   const SearchScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Get.put(SearchDataController()); // تهيئة الـ Controller
//     return Scaffold(
//       appBar: const CustomAppBar(
//         title: Text("بحث المكاتب العقارية"),
//         color: AppColor.white,
//       ),
//       body: GetBuilder<SearchDataController>(builder: (controller) {
//         return HandlingDataView(
//           statusRequest: controller.statusRequest!,
//           widget: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 // تصميم TextField مع مربع أحمر داخل suffixIcon
//                 TextField(
//                   controller: controller.searchController,
//                   decoration: InputDecoration(
//                     hintText: 'ابحث عن مكتب...',
//                     filled: true,
//                     fillColor: Colors.grey[200],
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                       borderSide: BorderSide.none,
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(
//                         vertical: 15, horizontal: 20),
//                     suffixIcon: Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: Container(
//                         width: MediaQuery.of(context).size.width * 0.2,
//                         margin: const EdgeInsets.only(right: 8),
//                         decoration: BoxDecoration(
//                           color: Colors.red,
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                         child: IconButton(
//                           icon: const Icon(Icons.search, color: Colors.white),
//                           onPressed: () {
//                             controller
//                                 .getData(); // إجراء البحث عند الضغط على الأيقونة
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                   onChanged: (value) {
//                     // تنفيذ الدالة مع تأخير (debounce)
//                     // controller.debounceSuggestions(value);
//                   },
//                   onSubmitted: (value) {
//                     // controller.getData(); // إجراء البحث عند الضغط على Enter
//                   },
//                 ),
//                 const SizedBox(height: 20),
//                 // عرض الاقتراحات فقط إذا كانت موجودة
//                 if (controller.suggestions.isNotEmpty)
//                   ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: controller.suggestions.length,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         title: Text(controller.suggestions[index].officeName!),
//                         onTap: () {
//                           // controller.searchController.text =
//                           //     controller.suggestions[index].officeName!;
//                           // controller.getData(); // تنفيذ البحث باستخدام الاقتراح
//                           // controller.suggestions =
//                           //     []; // مسح الاقتراحات بعد اختيار واحد
//                           // controller
//                           //     .update(); // تحديث الواجهة بعد مسح الاقتراحات
//                         },
//                       );
//                     },
//                   ),
//                 const SizedBox(height: 20),
//                 // عرض نتائج البحث
//                 Expanded(
//                   child: controller.officeData.isEmpty
//                       ? const Center(
//                           child: Text("ادخل كلمة البحث لعرض النتائج"))
//                       : ListView.builder(
//                           itemCount: controller.officeData.length,
//                           itemBuilder: (context, index) {
//                             final office = controller.officeData[index];
//                             return Card(
//                               margin: const EdgeInsets.symmetric(vertical: 5),
//                               child: ListTile(
//                                 title: Text(office.officeName!),
//                                 subtitle: Text(office.officeAddress!),
//                                 onTap: () {},
//                               ),
//                             );
//                           },
//                         ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }
