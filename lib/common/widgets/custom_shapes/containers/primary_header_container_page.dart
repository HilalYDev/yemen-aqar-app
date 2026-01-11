// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../../../../utils/constants/app_colors.dart';
import 'circular_container.dart';

class PrimaryHeaderContainerPage extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;

  const PrimaryHeaderContainerPage({
    super.key,
    required this.child,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: AppColors.apparcolor,
      padding: EdgeInsets.zero,
      child: Stack(
        children: [
          Positioned(
            top: -150,
            right: -250,
            child: CircularContainer(
              backgroundColor: AppColors.apparcolor.withOpacity(0.1),
            ),
          ),
          Positioned(
            top: 100,
            right: -300,
            child: CircularContainer(
              backgroundColor: AppColors.apparcolor.withOpacity(0.1),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
