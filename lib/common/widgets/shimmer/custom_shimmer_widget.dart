import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yemen_aqar/common/widgets/custom_shapes/containers/rounded_container.dart';

class CustomShimmerWidget extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final double radius;
  final bool showBorder;
  final bool showShadow;
  final Color borderColor;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final ShimmerDirection direction;
  final Duration duration;

  const CustomShimmerWidget({
    super.key,
    this.child,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.showBorder = false,
    this.showShadow = false,
    this.radius = 20,
    this.backgroundColor = Colors.grey,
    this.borderColor = Colors.grey,
    this.direction = ShimmerDirection.ltr,
    this.duration = const Duration(seconds: 2),
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[100]!,
      highlightColor: Colors.grey[200]!,
      direction: direction,
      child:
          child ??
          RoundedContainer(
            width: width,
            height: height,
            radius: radius,
            showBorder: showBorder,
            showShadow: showShadow,
            backgroundColor: backgroundColor ?? Colors.grey[300],
            borderColor: borderColor,
            padding: padding,
            margin: margin,
          ),
    );
  }
}
