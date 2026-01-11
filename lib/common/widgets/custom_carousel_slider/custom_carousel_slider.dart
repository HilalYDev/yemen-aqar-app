import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:yemen_aqar/common/widgets/custom_shapes/containers/rounded_container.dart';

import '../../../utils/constants/app_colors.dart';
import '../images/rounded_images.dart';

class CustomCarouselSlider extends StatefulWidget {
  final List<String> imageList;
  final bool autoPlay;
  final double aspectRatio;
  final double? height; // إضافة خيار تحديد الارتفاع

  final Axis scrollDirection;

  const CustomCarouselSlider({
    super.key,
    required this.imageList,
    this.autoPlay = true,
    this.aspectRatio = 16 / 9,
    this.height, // يمكن أن يكون null، وإذا لم يُحدد سيتم استخدام الـ aspectRatio

    this.scrollDirection = Axis.horizontal,
  });

  @override
  State<CustomCarouselSlider> createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  int currentIndex = 0; // المؤشر الحالي للصورة

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        SizedBox(height: screenHeight * 0.02), // تباعد علوي
        CarouselSlider.builder(
          itemCount: widget.imageList.length,
          itemBuilder: (context, index, realIndex) {
            var item = widget.imageList[index]; // اسم الصورة المحلية
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.001,
              ), // ضبط التباعد
              child: Container(
                margin: EdgeInsets.only(
                  bottom: screenHeight * 0.02,
                ), // إضافة تباعد سفلي
                child: RoundedContainer(
                  backgroundColor: AppColors.apparcolor,
                  showShadow: true,
                  child: RoundedImage1(
                    imageUrl: item,
                    width: screenWidth * 0.9,
                    height: widget.height ?? screenHeight * 0.25,
                    fit: BoxFit.cover,
                    isNetworkImage: false,
                    borderRadius: screenWidth * 0.05,
                  ),
                  // child: RoundedImage(
                  //   imageUrl: item,
                  //   width: screenWidth * 0.9,
                  //   height: widget.height ?? screenHeight * 0.25,
                  //   fit: BoxFit.cover,
                  //   isNetworkImage: false,
                  //   borderRadius: screenWidth * 0.05,
                  // ),
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: widget.height, // إذا تم تحديده، سيُستخدم كأولوية
            aspectRatio:
                widget.height == null
                    ? widget.aspectRatio
                    : double.nan, // تفادي الخطأ

            enlargeCenterPage: true,
            scrollDirection: widget.scrollDirection,
            autoPlay: widget.autoPlay,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
        SizedBox(height: screenHeight * 0.01), // مسافة بعد السلايدر
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.imageList.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
              width: screenWidth * 0.03,
              height: screenWidth * 0.03,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    currentIndex == index
                        ? AppColors
                            .deepNavy // دائرة ممتلئة
                        : Colors.transparent, // دوائر فارغة
                border:
                    currentIndex == index
                        ? null // عند التحديد، لا يوجد إطار
                        : Border.all(
                          color: AppColors.copperTan, // إطار عند عدم التحديد
                          width: screenWidth * 0.005,
                        ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
