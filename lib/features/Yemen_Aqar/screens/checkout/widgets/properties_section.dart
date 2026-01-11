// features/Yemen_Aqar/screens/order_confirmation/widgets/properties_section.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yemen_aqar/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:yemen_aqar/common/widgets/images/rounded_images.dart';
import 'package:yemen_aqar/common/widgets/texts/text_styles.dart';
import 'package:yemen_aqar/utils/constants/app_colors.dart';

import '../../../../../utils/helpers/currency_utils.dart';
import '../../../model/PropertyModel.dart';

class PropertiesSection extends StatelessWidget {
  final List<PropertyModel> cartItems;

  const PropertiesSection({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat('#,##0', 'ar_YE');

    return RoundedContainer(
      showShadow: true,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          Divider(height: 20, thickness: 1),
          ..._buildPropertyItems(formatCurrency),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Icon(Icons.home_outlined, color: AppColors.deepNavy),
        SizedBox(width: 8),
        AppTextStyles(
          title: "العقارات المطلوبة (${cartItems.length})",
          mediumSize: true,
          color: AppColors.deepNavy,
        ),
      ],
    );
  }

  List<Widget> _buildPropertyItems(NumberFormat formatCurrency) {
    return cartItems
        .map((property) => _buildPropertyItem(property, formatCurrency))
        .toList();
  }

  Widget _buildPropertyItem(
    PropertyModel property,
    NumberFormat formatCurrency,
  ) {
    double price = CurrencySummary.parsePrice(property.price);

    return RoundedContainer(
      margin: EdgeInsets.only(bottom: 12),
      showShadow: true,
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          _buildPropertyImage(property),
          SizedBox(width: 10),
          _buildPropertyInfo(property, price, formatCurrency),
        ],
      ),
    );
  }

  Widget _buildPropertyImage(PropertyModel property) {
    return RoundedContainer(
      width: 50,
      height: 50,
      radius: 10,
      child: RoundedImage1(
        isNetworkImage: true,
        imageUrl: "${property.image}",
        applyImageRadius: true,
      ),
    );
  }

  Widget _buildPropertyInfo(
    PropertyModel property,
    double price,
    NumberFormat formatCurrency,
  ) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppTextStyles(
            title: "${property.name}",
            mediumSize: true,
            maxLine: 2,
          ),
          SizedBox(height: 4),
          AppTextStyles(
            title: "${formatCurrency.format(price)} ${property.currency}",
            smallSize: true,
            color: AppColors.copperTan,
          ),
        ],
      ),
    );
  }
}
