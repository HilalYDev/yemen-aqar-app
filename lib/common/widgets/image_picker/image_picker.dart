import 'package:flutter/material.dart';
import 'package:yemen_aqar/common/widgets/texts/text_styles.dart';
import 'dart:io';

import 'package:yemen_aqar/utils/constants/app_colors.dart';

class ImagePickerWidget extends StatelessWidget {
  final String? title;
  final File? thumbnail; // صورة المصغرة الحالية من الجهاز
  final String? initialImageUrl; // رابط الصورة المبدئي من قاعدة البيانات
  final Function() chooseThumbnail; // دالة لاختيار صورة مصغرة

  const ImagePickerWidget({
    super.key,
    this.title = " اضف صورة ",
    this.thumbnail, // يمكن أن يكون فارغًا في صفحة التعديل
    this.initialImageUrl, // يمكن أن يكون فارغًا في صفحة الإضافة
    required this.chooseThumbnail, // استدعاء دالة اختيار الصورة
  });

  @override
  Widget build(BuildContext context) {
    // الحصول على عرض الشاشة باستخدام MediaQuery

    return GestureDetector(
      onTap: () {
        // إخفاء لوحة المفاتيح عند الضغط
        FocusScope.of(context).unfocus();
        // استدعاء الدالة لاختيار الصورة المصغرة
        chooseThumbnail();
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          // تحديد الأبعاد بناءً على عرض الشاشة
          final containerWidth =
              constraints.maxWidth * 0.99; // 90% من العرض المتاح
          final containerHeight =
              (thumbnail == null && initialImageUrl == null)
                  ? containerWidth *
                      0.16 // نسبة الارتفاع عندما لا توجد صورة
                  : containerWidth * 0.5; // نسبة الارتفاع عندما توجد صورة

          return Container(
            height: containerHeight,
            width: containerWidth,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: AppColors.copperTan, // تخصيص اللون
              ),
              borderRadius: BorderRadius.circular(10),
              color: Colors.transparent,
            ),
            child:
                (thumbnail == null && initialImageUrl == null)
                    // عندما لا توجد صورة محلية أو من قاعدة البيانات
                    ? Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_a_photo,
                            color: AppColors.copperTan,
                            size:
                                containerWidth *
                                0.1, // حجم الأيقونة نسبةً لعرض الشاشة
                          ),
                          SizedBox(
                            height: containerWidth * 0.02,
                          ), // مسافة بين الأيقونة والنص

                          AppTextStyles(
                            title: title!,
                            smallSize: true,
                            color: Colors.grey,
                          ),
                          // Text(
                          //   // 'أضف الصورة',
                          //   // " اضف صورة  $title",
                          //   title!,

                          //   style: TextStyle(
                          //     color: Colors.grey,
                          //     fontSize: containerWidth *
                          //         0.04, // حجم الخط نسبةً لعرض الشاشة
                          //   ),
                          // ),
                        ],
                      ),
                    )
                    // عندما توجد صورة محلية أو من قاعدة البيانات
                    : ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child:
                          thumbnail != null
                              // عرض الصورة المحلية إذا كانت موجودة (في حالة التعديل بعد اختيار صورة جديدة)
                              ? Image.file(
                                thumbnail!,
                                fit: BoxFit.contain,
                                width: containerWidth,
                                height: containerHeight,
                              )
                              // عرض الصورة من قاعدة البيانات إذا لم تكن هناك صورة محلية
                              : Image.network(
                                initialImageUrl!,
                                fit: BoxFit.contain,
                                width: containerWidth,
                                height: containerHeight,
                                errorBuilder: (context, error, stackTrace) {
                                  return Center(
                                    child: Icon(
                                      Icons.error,
                                      color: Colors.red,
                                      size:
                                          containerWidth *
                                          0.1, // حجم الأيقونة نسبةً لعرض الشاشة
                                    ),
                                  );
                                },
                              ),
                    ),
          );
        },
      ),
    );
  }
}

class ImagePickerFormField extends FormField<File> {
  ImagePickerFormField({
    super.key,
    required File? thumbnail,
    String? initialImageUrl,
    required Function() onPickImage,
    String title = " اضف صورة ",
    super.validator,
    AutovalidateMode super.autovalidateMode = AutovalidateMode.disabled,
  }) : super(
         initialValue: thumbnail,
         builder: (FormFieldState<File> state) {
           return GestureDetector(
             onTap: () {
               FocusScope.of(state.context).unfocus();
               onPickImage();
               state.didChange(thumbnail); // تحديث القيمة
             },
             child: LayoutBuilder(
               builder: (context, constraints) {
                 final containerWidth = constraints.maxWidth * 0.99;
                 final containerHeight =
                     (thumbnail == null && initialImageUrl == null)
                         ? containerWidth * 0.16
                         : containerWidth * 0.5;

                 return Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Container(
                       height: containerHeight,
                       width: containerWidth,
                       decoration: BoxDecoration(
                         border: Border.all(
                           width: 1,
                           color: AppColors.copperTan,
                         ),
                         borderRadius: BorderRadius.circular(10),
                         color: Colors.transparent,
                       ),
                       child:
                           (thumbnail == null && initialImageUrl == null)
                               ? Center(
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                     Icon(
                                       Icons.add_a_photo,
                                       color: AppColors.copperTan,
                                       size: containerWidth * 0.1,
                                     ),
                                     SizedBox(width: containerWidth * 0.02),
                                     AppTextStyles(
                                       title: title,
                                       smallSize: true,
                                       color: Colors.grey,
                                     ),
                                   ],
                                 ),
                               )
                               : ClipRRect(
                                 borderRadius: BorderRadius.circular(8),
                                 child:
                                     thumbnail != null
                                         ? Image.file(
                                           thumbnail,
                                           fit: BoxFit.contain,
                                           width: containerWidth,
                                           height: containerHeight,
                                         )
                                         : Image.network(
                                           initialImageUrl!,
                                           fit: BoxFit.contain,
                                           width: containerWidth,
                                           height: containerHeight,
                                           errorBuilder: (
                                             context,
                                             error,
                                             stackTrace,
                                           ) {
                                             return Center(
                                               child: Icon(
                                                 Icons.error,
                                                 color: Colors.red,
                                                 size: containerWidth * 0.1,
                                               ),
                                             );
                                           },
                                         ),
                               ),
                     ),
                     if (state.hasError)
                       Padding(
                         padding: const EdgeInsets.only(top: 8.0, left: 4.0),
                         child: Text(
                           state.errorText ?? '',
                           style: const TextStyle(
                             color: Colors.red,
                             fontSize: 12,
                           ),
                         ),
                       ),
                   ],
                 );
               },
             ),
           );
         },
       );
}
