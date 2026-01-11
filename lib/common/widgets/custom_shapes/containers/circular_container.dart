import 'package:flutter/material.dart';

import '../../../../utils/constants/app_colors.dart';

class CircularContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final double padding;
  final EdgeInsets? margin;
  final Widget? child;
  final double radius;
  final Color backgroundColor;

  const CircularContainer({
    super.key,
    this.width = 400,
    this.height = 400,
    this.padding = 0,
    this.margin,
    this.child,
    this.radius = 400,
    this.backgroundColor = AppColors.apparcolor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(padding),
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(400),
      ),
      child: child,
    );
  }
}
