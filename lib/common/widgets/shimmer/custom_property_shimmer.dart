import 'package:flutter/material.dart';
import 'package:yemen_aqar/common/widgets/shimmer/custom_shimmer_widget.dart';
import 'package:yemen_aqar/utils/constants/app_colors.dart';

import '../custom_shapes/containers/rounded_container.dart';

class CustomPropertyShimmer extends StatelessWidget {
  final int itemCount; // عدد العناصر التي سيتم عرضها

  const CustomPropertyShimmer({super.key, this.itemCount = 5});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: ListView.builder(
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Padding(
              padding: EdgeInsets.only(bottom: screenHeight * 0.02),
              child: RoundedContainer(
                height: screenHeight * 0.22,
                backgroundColor: AppColors.apparcolor,
                padding: EdgeInsets.all(screenWidth * 0.02),
                child: Row(
                  children: [
                    CustomShimmerWidget(
                      height: screenHeight * 0.22,
                      width: screenWidth * 0.3,
                      margin: EdgeInsets.all(screenWidth * 0.01),

                      // padding: EdgeInsets.all(screenWidth * 0.02),
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: screenHeight * 0.02),
                          child: CustomShimmerWidget(
                            height: screenHeight * 0.015,
                            // width: screenWidth * 0.3,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        CustomShimmerWidget(
                          height: screenHeight * 0.015,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        CustomShimmerWidget(
                          height: screenHeight * 0.015,
                          // width: screenWidth * 0.3,
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        CustomShimmerWidget(
                          height: screenHeight * 0.015,
                          // width: screenWidth * 0.3,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        CustomShimmerWidget(
                          height: screenHeight * 0.03,
                          width: screenWidth * 0.3,
                        ),
                        const Spacer(),
                        Padding(
                          padding: EdgeInsets.all(screenWidth * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomShimmerWidget(
                                height: screenHeight * 0.03,
                                width: screenWidth * 0.22,
                              ),
                              CustomShimmerWidget(
                                height: screenHeight * 0.03,
                                width: screenWidth * 0.22,
                              ),
                            ],
                          ),
                        )
                      ],
                    ))
                  ],
                ),
              ));
        },
      ),
    );
  }
}
