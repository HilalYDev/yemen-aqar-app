// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../curved_edges/curved_edge_widget.dart';
import 'circular_container.dart';

class PrimaryHeaderContainer extends StatelessWidget {
  final Widget child;
  const PrimaryHeaderContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return CurvedEdgeWidget(
      child: Container(
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
      ),
    );
  }
}
