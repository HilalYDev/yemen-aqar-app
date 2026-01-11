import 'package:flutter/widgets.dart';

class MQSizes {
  // نمرر context للحصول على MediaQuery
  final BuildContext context;

  MQSizes(this.context);

  Size get size => MediaQuery.of(context).size;

  // Padding and margin sizes
  double get xs => size.width * 0.01;
  double get sm => size.width * 0.02;
  double get md => size.width * 0.04;
  double get lg => size.width * 0.06;
  double get xl => size.width * 0.08;

  // Icon sizes
  double get iconXs => size.width * 0.03;
  double get iconSm => size.width * 0.04;
  double get iconMd => size.width * 0.06;
  double get iconLg => size.width * 0.08;

  // Font sizes
  double get fontSizeSm => size.width * 0.035;
  double get fontSizeMd => size.width * 0.04;
  double get fontSizeLg => size.width * 0.045;

  // Button sizes
  double get buttonHeight => size.height * 0.05;
  double get buttonRadius => size.width * 0.03;
  double get buttonWidth => size.width * 0.4;
  double get buttonElevation => size.height * 0.01;

  // AppBar height
  double get appBarHeight => size.height * 0.08;

  // Image sizes
  double get imageThumbSize => size.width * 0.2;

  // Default spacing between sections
  double get defaultSpace => size.height * 0.03;
  double get spaceBtwItems => size.height * 0.02;
  double get spaceBtwSections => size.height * 0.04;

  // Border radius
  double get borderRadiusSm => size.width * 0.01;
  double get borderRadiusMd => size.width * 0.02;
  double get borderRadiusLg => size.width * 0.03;

  // Divider height
  double get dividerHeight => size.height * 0.001;

  // Product item dimensions
  double get productImageSize => size.width * 0.3;
  double get productImageRadius => size.width * 0.04;
  double get productItemHeight => size.height * 0.2;

  // Input field
  double get inputFieldRadius => size.width * 0.03;
  double get spaceBtwInputFields => size.height * 0.02;

  // Card sizes
  double get cardRadiusLg => size.width * 0.04;
  double get cardRadiusMd => size.width * 0.03;
  double get cardRadiusSm => size.width * 0.025;
  double get cardRadiusXs => size.width * 0.015;
  double get cardElevation => size.height * 0.005;

  // Image carousel height
  double get imageCarouselHeight => size.height * 0.3;

  // Loading indicator size
  double get loadingIndicatorSize => size.width * 0.1;

  // Grid view spacing
  double get gridViewSpacing => size.width * 0.04;
}
