import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:yemen_aqar/common/widgets/shimmer/custom_shimmer_widget.dart';

class CustomCarouselShimmer extends StatelessWidget {
  final int itemCount;
  final double aspectRatio;
  final double? height;
  final Axis scrollDirection;

  const CustomCarouselShimmer({
    super.key,
    this.itemCount = 3, // عدد العناصر الوهمية
    this.aspectRatio = 16 / 9,
    this.height,
    this.scrollDirection = Axis.horizontal,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        SizedBox(height: screenHeight * 0.02), // تباعد علوي
        CarouselSlider.builder(
          itemCount: itemCount,
          itemBuilder: (context, index, realIndex) {
            return CustomShimmerWidget(
              // سرعة الحركة
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.001),
                child: Container(
                  margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(screenWidth * 0.05),
                  ),
                  child: SizedBox(
                    width: screenWidth * 0.9,
                    height: height ?? screenHeight * 0.25,
                  ),
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: height ?? screenHeight * 0.22,
            aspectRatio: aspectRatio,
            enlargeCenterPage: true,
            scrollDirection: scrollDirection,
            autoPlay: true, // لا داعي للتشغيل التلقائي في Shimmer
          ),
        ),
        SizedBox(height: screenHeight * 0.01), // مسافة بعد السلايدر
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(itemCount, (index) {
            return CustomShimmerWidget(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                width: screenWidth * 0.03,
                height: screenWidth * 0.03,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[300], // لون وهمي للنقاط
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
