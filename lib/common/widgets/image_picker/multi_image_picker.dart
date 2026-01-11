// // ignore_for_file: unnecessary_to_list_in_spreads

// import 'package:flutter/material.dart';
// import 'dart:io';

// import 'package:yemen_aqar/utils/constants/app_colors.dart';

// class MultiImagePicker extends StatelessWidget {
//   final List<File> productImages; // صور المنتج من الجهاز
//   final List<String>? initialImageUrls; // روابط الصور من قاعدة البيانات
//   final Function() chooseProductImages; // دالة لاختيار صور متعددة
//   final Function(int, {bool isFromDatabase})
//       removeProductImage; // دالة لحذف صورة من الجهاز أو من قاعدة البيانات

//   const MultiImagePicker({
//     super.key,
//     required this.productImages,
//     this.initialImageUrls, // روابط الصور من قاعدة البيانات، يمكن أن تكون فارغة
//     required this.chooseProductImages,
//     required this.removeProductImage,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // الحصول على عرض الشاشة باستخدام MediaQuery
//     // final screenWidth = MediaQuery.of(context).size.width;

//     return LayoutBuilder(
//       builder: (context, constraints) {
//         // تحديد الأبعاد بناءً على عرض الشاشة
//         final containerWidth =
//             constraints.maxWidth * 0.9; // 90% من العرض المتاح
//         final containerHeight = (productImages.isEmpty &&
//                 (initialImageUrls == null || initialImageUrls!.isEmpty))
//             ? containerWidth * 0.3 // نسبة الارتفاع عندما لا توجد صور
//             : containerWidth * 0.8; // نسبة الارتفاع عندما توجد صور

//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (productImages.isEmpty &&
//                 (initialImageUrls == null || initialImageUrls!.isEmpty))
//               GestureDetector(
//                 onTap: chooseProductImages,
//                 child: Container(
//                   height: containerHeight,
//                   width: containerWidth,
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       width: 1,
//                       color: AppColors.deepNavy,
//                     ),
//                     borderRadius: BorderRadius.circular(10),
//                     color: Colors.transparent,
//                   ),
//                   child: Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.add_photo_alternate_outlined,
//                           color: AppColors.deepNavy,
//                           size: containerWidth *
//                               0.1, // حجم الأيقونة نسبةً لعرض الشاشة
//                         ),
//                         SizedBox(
//                             height: containerWidth *
//                                 0.02), // مسافة بين الأيقونة والنص
//                         Text(
//                           'أضف صور للمنتج',
//                           style: TextStyle(
//                             color: Colors.grey,
//                             fontSize: containerWidth *
//                                 0.04, // حجم الخط نسبةً لعرض الشاشة
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             else
//               Container(
//                 height: containerHeight,
//                 width: containerWidth,
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     width: 1,
//                     color: AppColors.deepNavy,
//                   ),
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.transparent,
//                 ),
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: [
//                       // عرض الصور الموجودة مسبقًا من قاعدة البيانات
//                       if (initialImageUrls != null &&
//                           initialImageUrls!.isNotEmpty)
//                         ...initialImageUrls!.asMap().entries.map((entry) {
//                           int index = entry.key;
//                           String imageUrl = entry.value;
//                           return Container(
//                             margin: EdgeInsets.symmetric(
//                                 horizontal: containerWidth * 0.02),
//                             height: containerWidth * 0.25, // 25% من عرض الشاشة
//                             width: containerWidth * 0.25,
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                 width: 1,
//                                 color: AppColors.deepNavy,
//                               ),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Stack(
//                               children: [
//                                 GestureDetector(
//                                   onTap: chooseProductImages,
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(8),
//                                     child: Image.network(
//                                       imageUrl,
//                                       width: containerWidth * 0.25,
//                                       height: containerWidth * 0.25,
//                                       fit: BoxFit.cover,
//                                       errorBuilder:
//                                           (context, error, stackTrace) {
//                                         return Center(
//                                           child: Icon(
//                                             Icons.error,
//                                             color: Colors.red,
//                                             size: containerWidth * 0.1,
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                                 Positioned(
//                                   top: 0,
//                                   left: 0,
//                                   child: IconButton(
//                                     icon: Icon(
//                                       Icons.delete,
//                                       color: AppColors.deepNavy,
//                                       size: containerWidth * 0.06,
//                                     ),
//                                     onPressed: () => removeProductImage(index,
//                                         isFromDatabase: true),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         }).toList(),

//                       // عرض الصور التي تم اختيارها من الجهاز
//                       ...productImages.asMap().entries.map((entry) {
//                         int index = entry.key;
//                         File image = entry.value;
//                         return Container(
//                           margin: EdgeInsets.symmetric(
//                               horizontal: containerWidth * 0.02),
//                           height: containerWidth * 0.25, // 25% من عرض الشاشة
//                           width: containerWidth * 0.25,
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                               width: 1,
//                               color: AppColors.deepNavy,
//                             ),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Stack(
//                             children: [
//                               GestureDetector(
//                                 onTap: chooseProductImages,
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(8),
//                                   child: Image.file(
//                                     image,
//                                     fit: BoxFit.cover,
//                                     width: containerWidth * 0.25,
//                                     height: containerWidth * 0.25,
//                                   ),
//                                 ),
//                               ),
//                               Positioned(
//                                 top: 0,
//                                 left: 0,
//                                 child: IconButton(
//                                   icon: Icon(
//                                     Icons.delete,
//                                     color: AppColors.deepNavy,
//                                     size: containerWidth * 0.06,
//                                   ),
//                                   onPressed: () => removeProductImage(index),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       }).toList(),

//                       // زر إضافة صور جديدة
//                       GestureDetector(
//                         onTap: chooseProductImages,
//                         child: Container(
//                           margin: EdgeInsets.symmetric(
//                               horizontal: containerWidth * 0.02),
//                           width: containerWidth * 0.25,
//                           height: containerWidth * 0.25,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: AppColors.deepNavy.withOpacity(0.1),
//                           ),
//                           child: Icon(
//                             Icons.add_photo_alternate_outlined,
//                             color: AppColors.deepNavy,
//                             size: containerWidth * 0.1,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//           ],
//         );
//       },
//     );
//   }
// }
