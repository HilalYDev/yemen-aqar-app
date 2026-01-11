// features/Yemen_Aqar/screens/order_confirmation/widgets/currency_summary_section.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yemen_aqar/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:yemen_aqar/common/widgets/texts/text_styles.dart';
import 'package:yemen_aqar/utils/constants/app_colors.dart';

import '../../../../../utils/helpers/currency_utils.dart';

class CurrencySummarySection extends StatelessWidget {
  final CurrencySummary currencySummary;

  const CurrencySummarySection({super.key, required this.currencySummary});

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat('#,##0', 'ar_YE');

    return RoundedContainer(
      showShadow: true,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // العنوان
          Row(
            children: [
              Icon(Icons.receipt_outlined, color: AppColors.deepNavy),
              SizedBox(width: 8),
              AppTextStyles(
                title: "ملخص الطلب",
                mediumSize: true,
                color: AppColors.deepNavy,
              ),
            ],
          ),

          Divider(height: 20, thickness: 1),

          // 1. إجمالي عدد العقارات
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppTextStyles(
                title: "إجمالي عدد العقارات:",
                smallSize: true,
                color: AppColors.deepNavy,
              ),
              AppTextStyles(
                title: "${currencySummary.totalCount} عقار",
                smallSize: true,
                bold: true,
              ),
            ],
          ),

          SizedBox(height: 15),

          // 2. عرض كل العملات
          ...currencySummary.currencies.map((currency) {
            return Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: currency['color'].withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: currency['color'].withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  // أيقونة العملة
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: currency['color'].withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      currency['icon'],
                      size: 20,
                      color: currency['color'],
                    ),
                  ),

                  SizedBox(width: 12),

                  // معلومات العملة
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextStyles(
                          title: currency['name'],
                          smallSize: true,
                          color: currency['color'],
                          bold: true,
                        ),

                        SizedBox(height: 4),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppTextStyles(
                              title: "${currency['count']} عقار",
                              smallSize: true,
                              color: Colors.grey[600],
                            ),

                            AppTextStyles(
                              title:
                                  "${formatCurrency.format(currency['total'])}",
                              smallSize: true,
                              color: currency['color'],
                              bold: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),

          // 3. الإجمالي النهائي
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: _buildFinalTotal(formatCurrency),
          ),
        ],
      ),
    );
  }

  Widget _buildFinalTotal(NumberFormat formatCurrency) {
    // إذا كان هناك عملة واحدة فقط
    if (currencySummary.currencies.length == 1) {
      final currency = currencySummary.currencies.first;

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppTextStyles(
            title: "الإجمالي النهائي:",
            mediumSize: true,
            color: AppColors.deepNavy,
            bold: true,
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AppTextStyles(
                title:
                    "${formatCurrency.format(currency['total'])} ${currency['name']}",
                mediumSize: true,
                color: AppColors.copperTan,
                bold: true,
              ),

              SizedBox(height: 4),

              AppTextStyles(
                title: "(${currency['count']} عقار)",
                smallSize: true,
                color: Colors.grey[600],
              ),
            ],
          ),
        ],
      );
    }

    // إذا كان هناك أكثر من عملة
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextStyles(
          title: "الملخص النهائي:",
          mediumSize: true,
          color: AppColors.deepNavy,
          bold: true,
        ),

        SizedBox(height: 10),

        // عرض كل عملة مع مجموعها
        ...currencySummary.currencies.map((currency) {
          return Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // اسم العملة مع أيقونتها
                Row(
                  children: [
                    Icon(currency['icon'], size: 18, color: currency['color']),

                    SizedBox(width: 8),

                    AppTextStyles(
                      title: "مجموع ${currency['name']}:",
                      smallSize: true,
                    ),
                  ],
                ),

                // المجموع وعدد العقارات
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AppTextStyles(
                      title: "${formatCurrency.format(currency['total'])}",
                      smallSize: true,
                      color: currency['color'],
                      bold: true,
                    ),

                    AppTextStyles(
                      title: "(${currency['count']} عقار)",
                      smallSize: true,
                      color: Colors.grey[600],
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}
