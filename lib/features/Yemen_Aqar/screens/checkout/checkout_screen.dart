import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/appBar/custom_app_bar.dart';
import '../../../../utils/helpers/currency_utils.dart';
import '../../controller/checkout_controller.dart';
import '../../model/PropertyModel.dart';
import 'widgets/properties_section.dart';
import 'widgets/currency_summary_section.dart';
import 'widgets/notes_section.dart';
import 'widgets/confirmation_button.dart';

class CheckoutScreen extends StatelessWidget {
  final List<PropertyModel> cartItems;
  final CurrencySummary currencySummary;

  CheckoutScreen({super.key, required this.cartItems})
    : currencySummary = CurrencySummary.fromProperties(cartItems);

  @override
  Widget build(BuildContext context) {
    Get.put(CheckoutController());

    return Scaffold(
      appBar: CustomAppBar(title: "تأكيد الطلب", showBackButton: true),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          PropertiesSection(cartItems: cartItems),
          SizedBox(height: 20),
          CurrencySummarySection(currencySummary: currencySummary),
          SizedBox(height: 20),
          NotesSection(),
          SizedBox(height: 20),
          ConfirmationButton(
            cartItems: cartItems,
            currencySummary: currencySummary,
          ),
        ],
      ),
    );
  }
}
