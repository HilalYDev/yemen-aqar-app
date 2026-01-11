import 'package:flutter/material.dart';
import 'package:yemen_aqar/common/widgets/texts/text_styles.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/media_query_sizes.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String labelText; // نص التسمية
  final List<T> items; // العناصر التي ستظهر في القائمة المنسدلة
  final T? value; // القيمة المحددة
  final ValueChanged<T?> onChanged; // دالة التغيير
  final FormFieldValidator<T>? validator; // دالة التحقق
  final IconData? prefixIcon; // أيقونة بادئة

  const CustomDropdown({
    super.key,
    required this.labelText,
    required this.items,
    required this.value,
    required this.onChanged,
    this.validator,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final sizes = MQSizes(context);
    TextStyle? textStyle = Theme.of(context).textTheme.titleSmall;

    return DropdownButtonFormField<T>(
      isExpanded: true, // توسيع القائمة المنسدلة لتملأ المساحة المتاحة
      value: value, // تعيين القيمة المحددة
      onChanged: onChanged,
      items:
          items.map<DropdownMenuItem<T>>((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Container(
                alignment: Alignment.center, // جعل النص في المنتصف
                child: AppTextStyles(title: item.toString(), smallSize: true),
              ),
            );
          }).toList(),
      decoration: InputDecoration(
        filled: true,
        labelText: labelText,
        labelStyle: textStyle,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(120)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(120),
          borderSide: const BorderSide(
            color: AppColors.copperTan, // لون الإطار عند التركيز
            width: 2.0, // سمك الإطار
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(120),
          borderSide: const BorderSide(
            color: AppColors.copperTan, // لون الإطار عند التفعيل
            width: 2.0, // سمك الإطار
          ),
        ),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        contentPadding: EdgeInsets.symmetric(
          vertical: sizes.md, // تباعد عمودي
        ),
        floatingLabelAlignment:
            FloatingLabelAlignment.center, // وضع التسمية في المنتصف
      ),
      validator: validator,
      menuMaxHeight: 200, // ارتفاع النافذة المنبثقة
      dropdownColor: Colors.white, // لون خلفية النافذة المنبثقة
      borderRadius: BorderRadius.circular(8), // جعل النافذة مربعة
    );
  }
}
