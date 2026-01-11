import 'package:flutter/material.dart';

import '../custom_shapes/containers/rounded_container.dart';

class CustomButton extends StatelessWidget {
  final Widget iconWidget;
  final String text;
  final Color backgroundColor;
  final VoidCallback onTap;
  final double? height;

  const CustomButton({
    super.key,
    required this.iconWidget,
    required this.text,
    required this.backgroundColor,
    required this.onTap,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: onTap,
      child: RoundedContainer(
        height: height ?? screenHeight * 0.03,
        width: screenWidth * 0.22,
        showBorder: true,
        backgroundColor: backgroundColor,
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
        margin: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.01,
        ), // ← إضافة مسافة هنا
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconWidget,

            SizedBox(width: screenWidth * 0.02),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.030,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
