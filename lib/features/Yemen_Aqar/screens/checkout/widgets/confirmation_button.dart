// features/Yemen_Aqar/screens/order_confirmation/widgets/confirmation_button.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yemen_aqar/utils/constants/app_colors.dart';
import '../../../../../common/widgets/mybutton/mybutton.dart';
import '../../../../../utils/class/statusrequest.dart';
import '../../../../../utils/helpers/currency_utils.dart';
import '../../../controller/checkout_controller.dart';
import '../../../model/PropertyModel.dart';

class ConfirmationButton extends StatelessWidget {
  final List<PropertyModel> cartItems;
  final CurrencySummary currencySummary;

  const ConfirmationButton({
    super.key,
    required this.cartItems,
    required this.currencySummary,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckoutController>(
      builder: (controller) {
        return MyButtons(
          textbutton: "تأكيد الطلب",
          onPress: () {
            controller.checkout();
          },
          buttonColor: AppColors.deepNavy,
          textColor: Colors.white,
          isLoading: controller.statusRequest == StatusRequest.loading,
        );
      },
    );
  }
}

// // features/Yemen_Aqar/screens/order_confirmation/widgets/confirmation_button.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:yemen_aqar/common/widgets/texts/text_styles.dart';
// import 'package:yemen_aqar/utils/constants/app_colors.dart';
// import '../../../../../utils/helpers/currency_utils.dart';
// import '../../../controller/checkout_controller.dart';
// import '../../../model/PropertyModel.dart';

// class ConfirmationButton extends StatelessWidget {
//   final List<PropertyModel> cartItems;
//   final CurrencySummary currencySummary;

//   const ConfirmationButton({
//     super.key,
//     required this.cartItems,
//     required this.currencySummary,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final CheckoutController controller = Get.find<CheckoutController>();

//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
//       ),
//       child: SizedBox(
//         width: double.infinity,
//         height: 50,
//         child: ElevatedButton(
//           onPressed: () {},
//           style: ElevatedButton.styleFrom(
//             backgroundColor: AppColors.deepNavy,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//           child: const Text("تأكيد الطلب", style: TextStyle(fontSize: 16)),
//         ),
//       ),
//     );
//   }

//   void _showConfirmationDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder:
//           (context) => AlertDialog(
//             title: Row(
//               children: [
//                 Icon(Icons.check_circle, color: Colors.green),
//                 SizedBox(width: 10),
//                 AppTextStyles(title: "تأكيد الطلب", mediumSize: true),
//               ],
//             ),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 AppTextStyles(
//                   title: "هل أنت متأكد من تأكيد الطلب؟",
//                   smallSize: true,
//                 ),
//                 SizedBox(height: 10),
//                 AppTextStyles(
//                   title:
//                       "• سيتصل بك مندوبنا خلال 24 ساعة\n• يمكنك متابعة طلبك من قسم 'طلباتي'",
//                   smallSize: true,
//                   color: AppColors.copperTan,
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Get.back(),
//                 child: AppTextStyles(title: "إلغاء", color: AppColors.deepNavy),
//               ),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.deepNavy,
//                 ),
//                 onPressed: () {
//                   Get.back();
//                   _showSuccessMessage(context);
//                 },
//                 child: AppTextStyles(title: "تأكيد", color: Colors.white),
//               ),
//             ],
//           ),
//     );
//   }

//   void _showSuccessMessage(BuildContext context) {
//     final formatCurrency = NumberFormat('#,##0', 'ar_YE');

//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder:
//           (context) => AlertDialog(
//             title: Icon(Icons.check_circle, size: 60, color: Colors.green),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 AppTextStyles(title: "تم تأكيد طلبك بنجاح!", mediumSize: true),
//                 SizedBox(height: 10),
//                 AppTextStyles(
//                   title:
//                       "رقم الطلب: #ORD${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}",
//                   smallSize: true,
//                   color: AppColors.copperTan,
//                 ),
//                 SizedBox(height: 10),

//                 _buildOrderSummary(formatCurrency),

//                 SizedBox(height: 20),
//                 AppTextStyles(
//                   title:
//                       "• سيتصل بك المندوب خلال 24 ساعة\n• يمكنك متابعة الطلب من قسم 'طلباتي'",
//                   smallSize: true,
//                 ),
//               ],
//             ),
//             actions: [
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Get.until((route) => route.isFirst);
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.deepNavy,
//                   ),
//                   child: Text("عودة للرئيسية"),
//                 ),
//               ),
//             ],
//           ),
//     );
//   }

//   Widget _buildOrderSummary(NumberFormat formatCurrency) {
//     if (currencySummary.currencies.length == 1) {
//       return AppTextStyles(
//         title:
//             "الإجمالي: ${formatCurrency.format(currencySummary.currencies.first['total'])} ${currencySummary.currencies.first['name']}",
//         smallSize: true,
//       );
//     } else {
//       return AppTextStyles(
//         title: "تم تأكيد طلب ${currencySummary.totalCount} عقار",
//         smallSize: true,
//       );
//     }
//   }
// }
