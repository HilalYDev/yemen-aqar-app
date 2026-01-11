import 'package:flutter/material.dart';
import 'package:yemen_aqar/common/widgets/shimmer/custom_carousel_shimmer.dart';

import 'custom_shimmer_widget.dart';

class ReusableListShimmer extends StatelessWidget {
  final int itemCount; // عدد العناصر التي سيتم عرضها

  const ReusableListShimmer({super.key, this.itemCount = 3});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          const CustomCarouselShimmer(),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            height:
                (itemCount * 100) + 100, // تحديد ارتفاع بناءً على عدد العناصر
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Text("dat;l'l;'l'a"),
                // ✅ الحاوية الجانبية الثابتة تبدأ من الأعلى
                Positioned(
                  top: 0,
                  right: 0,
                  child: CustomShimmerWidget(
                    child: Container(
                      width: 60,
                      height:
                          (itemCount * 100) + 50, // ✅ الحساب الديناميكي للطول
                      decoration: BoxDecoration(
                        color: Colors.grey[300], // لون خفيف للتأثير
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),

                // ✅ تكرار العناصر بناءً على عدد البيانات مع تعديل المواقع
                ...List.generate(itemCount, (index) {
                  double offsetY = index * 100; // الاحتفاظ بنفس المسافات

                  return Stack(
                    children: [
                      // ✅ الحاوية الرئيسية للعناصر
                      Positioned(
                        top: 40 + offsetY,
                        right: 50,
                        child: CustomShimmerWidget(
                          child: Container(
                            width: screenWidth * 0.9 - 60,
                            height: 70,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // ✅ أيقونة العقار داخل الدائرة
                      Positioned(
                        top: 40 + offsetY,
                        right: 10,
                        child: CustomShimmerWidget(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.grey[300]!,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // ✅ السهم داخل الدائرة الصغيرة
                      Positioned(
                        top: 60 + offsetY,
                        left: screenWidth / 2 - (screenWidth * 0.9 - 40) / 2,
                        child: CustomShimmerWidget(
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
