// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:yemen_aqar/utils/constants/app_colors.dart';

import '../images/rounded_images.dart';
import '../texts/text_styles.dart';

class ReusableCategoryList<T> extends StatelessWidget {
  final List<T> items; // ✅ قائمة العناصر التي سيتم عرضها
  final Function(T) onItemTap; // ✅ حدث النقر على العنصر
  final String Function(T) getName; // ✅ دالة لاستخراج الاسم
  final String Function(T) getImageUrl; // ✅ دالة اختيارية لاسترداد الصورة

  const ReusableCategoryList({
    super.key,
    required this.items,
    required this.onItemTap,
    required this.getName,
    required this.getImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: (items.length * 100) + 100, // تحديد ارتفاع بناءً على عدد العناصر
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // ✅ الحاوية الجانبية الثابتة تبدأ من الأعلى
          if (items.isNotEmpty)
            Positioned(
              top: 0, // تعديل القيمة لتبدأ من الأعلى
              right: 0,
              child: Container(
                width: 60,
                height: (items.length * 100) + 50, // ✅ الحساب الديناميكي للطول
                decoration: BoxDecoration(
                  color: AppColors.copperTan,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
              ),
            ),

          // ✅ تكرار العناصر بناءً على عدد البيانات مع تعديل المواقع
          ...List.generate(items.length, (index) {
            var item = items[index]; // ✅ جلب بيانات العنصر
            double offsetY = index * 100; // الاحتفاظ بنفس المسافات

            return Stack(
              children: [
                // ✅ الحاوية الرئيسية للعناصر
                Positioned(
                  top: 40 + offsetY, // تعديل الموضع بناءً على المسافة من الأعلى
                  right: 50,
                  child: GestureDetector(
                    onTap: () => onItemTap(item), // ✅ حدث النقر
                    child: Container(
                      width: screenWidth * 0.9 - 60,
                      height: 70,
                      decoration: BoxDecoration(
                        color: AppColors.apparcolor,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 40,
                          top: 8,
                          bottom: 8,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextStyles(title: getName(item), height: 1),
                            AppTextStyles(
                              title: " هل تبحث على ${getName(item)}",
                              // mediumSize: true,
                              smallSize: true,
                              color: AppColors.copperTan,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // ✅ أيقونة العقار داخل الدائرة
                Positioned(
                  top: 40 + offsetY, // تعديل الموضع بناءً على المسافة من الأعلى
                  right: 10,
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: AppColors.apparcolor,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.copperTan, width: 2),
                    ),
                    child: ClipOval(
                      child:
                          getImageUrl(item).isNotEmpty
                              // ? RoundedImage(
                              //   isNetworkImage: true,
                              //   imageUrl: getImageUrl(item),
                              // )
                              ? RoundedImage1(
                                isNetworkImage: true,
                                imageUrl: getImageUrl(item),
                                width: 70,
                                height: 70,
                                applyImageRadius: false,
                              )
                              : const Icon(
                                Icons.home, // ✅ أيقونة بديلة في حالة حدوث خطأ
                                color: AppColors.deepNavy,
                                size: 30,
                              ),
                    ),
                  ),
                ),

                // ✅ السهم داخل الدائرة الصغيرة
                Positioned(
                  top: 60 + offsetY, // تعديل الموضع بناءً على المسافة من الأعلى
                  left: screenWidth / 2 - (screenWidth * 0.9 - 40) / 2,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: AppColors.deepNavy,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: AppColors.copperTan,
                        size: 15,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
