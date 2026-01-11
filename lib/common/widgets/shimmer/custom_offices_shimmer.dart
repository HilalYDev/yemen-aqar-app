import 'package:flutter/material.dart';
import 'package:yemen_aqar/common/widgets/shimmer/custom_shimmer_widget.dart';

import '../custom_shapes/containers/rounded_container.dart';

class CustomOfficesShimmer extends StatelessWidget {
  final int itemCount; // عدد العناصر التي سيتم عرضها

  const CustomOfficesShimmer({super.key, this.itemCount = 5});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: ListView.builder(
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.02,
                left: screenWidth * 0.05,
                right: screenWidth * 0.05,
              ),
              child: RoundedContainer(
                padding: EdgeInsets.all(screenWidth * 0.03),
                child: Row(
                  children: [
                    CustomShimmerWidget(
                      width: screenWidth * 0.15,
                      height: screenWidth * 0.15,
                      radius: screenWidth * 0.075,
                      // margin: EdgeInsets.all(screenWidth * 0.01),

                      // padding: EdgeInsets.all(screenWidth * 0.02),
                    ),
                    SizedBox(width: screenWidth * 0.05),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: screenHeight * 0.01),
                        CustomShimmerWidget(
                          height: screenHeight * 0.03,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        CustomShimmerWidget(
                          height: screenHeight * 0.03,
                          // width: screenWidth * 0.3,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        CustomShimmerWidget(
                          height: screenHeight * 0.03,
                          // width: screenWidth * 0.3,
                        ),
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
