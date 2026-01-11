// import '../../features/Yemen_Aqar/model/PropertyModel.dart';

// class CurrencyUtils {
//   static Map<String, dynamic> calculateSummary(List<PropertyModel> items) {
//     double totalSAR = 0;
//     double totalUSD = 0;
//     double totalYER = 0;

//     int countSAR = 0;
//     int countUSD = 0;
//     int countYER = 0;

//     for (var item in items) {
//       final cleanPrice = item.price?.replaceAll(',', '') ?? '0';
//       final price = double.tryParse(cleanPrice) ?? 0;

//       switch (item.currency) {
//         case 'ريال سعودي':
//           totalSAR += price;
//           countSAR++;
//           break;
//         case 'دولار أمريكي':
//           totalUSD += price;
//           countUSD++;
//           break;
//         case 'ريال يمني':
//           totalYER += price;
//           countYER++;
//           break;
//       }
//     }

//     return {
//       'SAR': {'count': countSAR, 'total': totalSAR},
//       'USD': {'count': countUSD, 'total': totalUSD},
//       'YER': {'count': countYER, 'total': totalYER},
//     };
//   }
// }
// utils/helpers/currency_utils.dart
import 'package:flutter/material.dart';

import '../../features/Yemen_Aqar/model/PropertyModel.dart';

class CurrencySummary {
  CurrencySummary(); // ✅ هذا هو الحل

  int saudiCount = 0;
  double saudiTotal = 0.0;

  int dollarCount = 0;
  double dollarTotal = 0.0;

  int yemeniCount = 0;
  double yemeniTotal = 0.0;

  int otherCount = 0;
  double otherTotal = 0.0;
  String otherCurrency = '';

  // تحويل السعر من نص إلى رقم
  static double parsePrice(String? price) {
    if (price == null || price.isEmpty) return 0.0;

    // إزالة الفواصل والمسافات
    String cleaned = price.replaceAll(',', '').replaceAll(' ', '');

    return double.tryParse(cleaned) ?? 0.0;
  }

  // تحليل قائمة العقارات
  factory CurrencySummary.fromProperties(List<PropertyModel> properties) {
    final summary = CurrencySummary();

    for (var property in properties) {
      double price = parsePrice(property.price);
      String currency = property.currency?.toLowerCase() ?? '';

      if (currency.contains('ريال سعودي') || currency == 'ريال') {
        summary.saudiCount++;
        summary.saudiTotal += price;
      } else if (currency.contains('دولار') || currency.contains('usd')) {
        summary.dollarCount++;
        summary.dollarTotal += price;
      } else if (currency.contains('ريال يمني') || currency.contains('yer')) {
        summary.yemeniCount++;
        summary.yemeniTotal += price;
      } else {
        summary.otherCount++;
        summary.otherTotal += price;
        summary.otherCurrency = property.currency ?? 'عملة أخرى';
      }
    }

    return summary;
  }

  // الحصول على إجمالي عدد العقارات
  int get totalCount {
    return saudiCount + dollarCount + yemeniCount + otherCount;
  }

  // التحقق إذا كان هناك عملة معينة
  bool get hasSaudi => saudiCount > 0;
  bool get hasDollar => dollarCount > 0;
  bool get hasYemeni => yemeniCount > 0;
  bool get hasOther => otherCount > 0;

  // الحصول على جميع العملات الموجودة
  List<Map<String, dynamic>> get currencies {
    List<Map<String, dynamic>> result = [];

    if (hasSaudi) {
      result.add({
        'name': 'ريال سعودي',
        'count': saudiCount,
        'total': saudiTotal,
        'icon': Icons.flag,
        'color': Colors.green,
      });
    }

    if (hasDollar) {
      result.add({
        'name': 'دولار أمريكي',
        'count': dollarCount,
        'total': dollarTotal,
        'icon': Icons.attach_money,
        'color': Colors.blue,
      });
    }

    if (hasYemeni) {
      result.add({
        'name': 'ريال يمني',
        'count': yemeniCount,
        'total': yemeniTotal,
        'icon': Icons.flag_outlined,
        'color': Colors.orange,
      });
    }

    if (hasOther) {
      result.add({
        'name': otherCurrency,
        'count': otherCount,
        'total': otherTotal,
        'icon': Icons.currency_exchange,
        'color': Colors.purple,
      });
    }

    return result;
  }
}
