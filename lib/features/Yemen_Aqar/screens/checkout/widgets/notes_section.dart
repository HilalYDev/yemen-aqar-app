// features/Yemen_Aqar/screens/order_confirmation/widgets/notes_section.dart
import 'package:flutter/material.dart';
import 'package:yemen_aqar/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:yemen_aqar/common/widgets/texts/text_styles.dart';
import 'package:yemen_aqar/utils/constants/app_colors.dart';

class NotesSection extends StatelessWidget {
  final TextEditingController _noteController = TextEditingController();

  NotesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      showShadow: true,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          Divider(height: 20, thickness: 1),
          _buildTextField(),
          SizedBox(height: 10),
          _buildHint(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Icon(Icons.note_outlined, color: AppColors.deepNavy),
        SizedBox(width: 8),
        AppTextStyles(
          title: "ملاحظات إضافية (اختياري)",
          mediumSize: true,
          color: AppColors.deepNavy,
        ),
      ],
    );
  }

  Widget _buildTextField() {
    return TextField(
      controller: _noteController,
      maxLines: 4,
      decoration: InputDecoration(
        hintText: "اكتب ملاحظاتك هنا (مواعيد الزيارة، أسئلة إضافية، ...)",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.copperTan),
        ),
        contentPadding: EdgeInsets.all(12),
      ),
    );
  }

  Widget _buildHint() {
    return AppTextStyles(
      title:
          "• يمكنك تحديد مواعيد الزيارة المناسبة لك\n• يمكنك طلب معلومات إضافية عن العقار",
      smallSize: true,
      color: AppColors.copperTan,
    );
  }

  String getNote() {
    return _noteController.text;
  }
}
