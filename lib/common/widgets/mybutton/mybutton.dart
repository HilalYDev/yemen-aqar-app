import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/media_query_sizes.dart';
import '../../../utils/formatters/formatter.dart';

// import 'utils/constants/color.dart';
class MyButtons extends StatelessWidget {
  final Function()? onPress;
  final String textbutton;
  final Color? buttonColor; // لون الزر (اختياري)
  final Color? textColor; // لون النص (اختياري)
  final bool isLoading; // حالة التحميل

  const MyButtons({
    super.key,
    required this.textbutton,
    this.onPress,
    this.buttonColor, // متغير لون الزر
    this.textColor, // متغير لون النص
    this.isLoading = false, // حالة التحميل (افتراضيًا false)
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MaterialButton(
      minWidth: size.width * 0.95,
      height: size.width * 0.12,
      color:
          buttonColor ??
          AppColors.deepNavy, // إذا لم يُحدد، يستخدم اللون الافتراضي
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(120)),
      ),
      onPressed: isLoading ? null : onPress,

      child:
          isLoading
              ? const SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  color: AppColors.deepNavy, // لون مؤشر التحميل
                ),
              )
              : Text(
                textbutton,
                style: TextStyle(
                  color:
                      textColor ??
                      Colors.white, // إذا لم يُحدد، يستخدم اللون الافتراضي
                  fontSize: 18, // حجم الخط
                  fontWeight: FontWeight.bold, // سمك الخط
                ),
              ),
    );
  }
}

class HelalTextBox extends StatefulWidget {
  const HelalTextBox({
    super.key,
    required this.ctrl,
    required this.hint,
    this.icon = Icons.person,
    this.isPassword = false,
    this.isPhone = false,
    this.valid,
    this.len,
    this.enabled = true,
    required this.labeltext,
    this.isMultiline = false,
    this.isNumber = false,
    this.isFormatted = false,
    this.isSearch = false, // خاصية جديدة لدعم البحث
    this.onSearchPressed, // دالة البحث
    this.onChanged, // دالة عند تغيير النص
    this.onFieldSubmitted, // دالة عند إرسال النص
  });

  final String? Function(String?)? valid;
  final String hint;
  final String labeltext;
  final IconData icon;
  final bool isPassword;
  final bool isPhone;
  final bool enabled;
  final int? len;
  final TextEditingController ctrl;
  final bool isMultiline;
  final bool isNumber;
  final bool isFormatted;
  final bool isSearch; // خاصية جديدة
  final VoidCallback? onSearchPressed; // دالة البحث
  final ValueChanged<String>? onChanged; // دالة عند تغيير النص
  final ValueChanged<String>? onFieldSubmitted; // دالة عند إرسال النص

  @override
  State<HelalTextBox> createState() => _HelalTextBoxState();
}

class _HelalTextBoxState extends State<HelalTextBox> {
  bool _obscureText = true;

  // دالة لإزالة الفواصل
  String removeCommas(String value) {
    return Formatter.removeCommas(value);
  }

  @override
  Widget build(BuildContext context) {
    final sizes = MQSizes(context);
    TextStyle? textStyle = Theme.of(context).textTheme.titleSmall;

    return TextFormField(
      validator: widget.valid,
      style: textStyle,
      obscureText: widget.isPassword ? _obscureText : false,
      controller: widget.ctrl,
      maxLength: widget.len,
      maxLines: widget.isMultiline ? null : 1,
      keyboardType:
          widget.isPhone
              ? TextInputType.phone
              : (widget.isNumber
                  ? TextInputType.number
                  : (widget.isMultiline
                      ? TextInputType.multiline
                      : TextInputType.text)),
      textAlign: widget.isPhone ? TextAlign.center : TextAlign.start,
      decoration: InputDecoration(
        filled: true,
        enabled: widget.enabled,
        counterText: '',
        contentPadding: EdgeInsets.symmetric(horizontal: sizes.md),
        labelStyle: textStyle,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(120)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(120),
          borderSide: const BorderSide(color: AppColors.copperTan),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(120),
          borderSide: const BorderSide(color: AppColors.copperTan),
        ),
        labelText: widget.labeltext,
        hintText: widget.hint,
        floatingLabelAlignment: FloatingLabelAlignment.center,
        prefixIcon:
            !widget.isPhone
                ? Icon(widget.icon, color: AppColors.deepNavy)
                : null,
        suffixIcon:
            widget.isPhone
                ? Padding(
                  padding: EdgeInsets.only(left: sizes.md, right: sizes.md),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '967+ ', // كود الدولة
                      ),
                    ],
                  ),
                )
                : (widget.isPassword
                    ? IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      icon:
                          _obscureText
                              ? const Icon(
                                Icons.visibility_off,
                                color: Colors.grey,
                              )
                              : const Icon(
                                Icons.remove_red_eye_outlined,
                                color: Colors.grey,
                              ),
                    )
                    : (widget.isSearch
                        ? Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.15,
                            // margin: EdgeInsets.only(right: 8),
                            height: MediaQuery.of(context).size.height * 0.05,
                            // width: 100,
                            decoration: BoxDecoration(
                              color: AppColors.deepNavy,
                              borderRadius: BorderRadius.circular(120.0),
                              // borderRadius: const BorderRadius.only(
                              //   topLeft: Radius.circular(10),
                              //   bottomLeft: Radius.circular(10),
                              // ),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.search,
                                color: AppColors.copperTan,
                              ),
                              onPressed: widget.onSearchPressed,
                            ),
                          ),
                        )
                        : null)),
      ),
      inputFormatters:
          widget.isFormatted
              ? [
                FilteringTextInputFormatter.digitsOnly,
                TextInputFormatter.withFunction((oldValue, newValue) {
                  final newText = Formatter.removeCommas(newValue.text);
                  final formattedText = Formatter.formatNumberWithComma(
                    newText,
                  );

                  final newCursorPosition =
                      newValue.selection.baseOffset +
                      (formattedText.length - newValue.text.length);
                  return newValue.copyWith(
                    text: formattedText,
                    selection: TextSelection.collapsed(
                      offset: newCursorPosition,
                    ),
                  );
                }),
              ]
              : [],
      onChanged: widget.onChanged, // تمرير onChanged
      onFieldSubmitted: widget.onFieldSubmitted, // تمرير onFieldSubmitted
    );
  }
}

// class HelalTextBox extends StatefulWidget {
//   const HelalTextBox({
//     super.key,
//     required this.ctrl,
//     required this.hint,
//     this.icon = Icons.person,
//     this.isPassword = false,
//     this.isPhone = false,
//     this.valid,
//     required this.len,
//     this.enabled = true,
//     this.width = double.infinity, // عرض الحقل الافتراضي
//     this.height = 50.0, // ارتفاع الحقل الافتراضي
//   });

//   final String? Function(String?)? valid;
//   final String hint;
//   final IconData icon;
//   final bool isPassword;
//   final bool isPhone;
//   final bool enabled;
//   final int len;
//   final double width;
//   final double height;
//   final TextEditingController ctrl;

//   @override
//   State<HelalTextBox> createState() => _HelalTextBoxState();
// }

// class _HelalTextBoxState extends State<HelalTextBox> {
//   String? error;
//   bool _obscureText = true;
//   @override
//   Widget build(BuildContext context) {
//     // Size _s = MediaQuery.of(context).size;
//     return SizedBox(
//           width: widget.width,
//       height: widget.height,
//       child: TextFormField(
        
//         validator: (String? value) => widget.valid!(
//             value), //  إذا كانت فاضية يظهر به رسالهTextFormField التحقق من قيمة
//         style: const TextStyle(
//             // color: Theme.of(context).primaryColor,
//             ), //لون النص المكتوب
      
//         obscureText:
//             widget.isPassword ? (_obscureText) : false, //تشفير النص المدخل
//         controller: widget.ctrl,
//         maxLength: widget.len, //طول النص المدخل
//         decoration: InputDecoration(
          
//           // fillColor: AppColor.appardark,
//           filled: true,
//           enabled: widget.enabled,
//           counterText: '', //اظهار عاداد للنص اسفل التكست
//                contentPadding: EdgeInsets.symmetric(
//             vertical: widget.height * 0.25, // ضبط الحشو بناءً على الارتفاع
//             horizontal: 16.0,
//           ),
//           labelStyle:
//               const TextStyle(color: AppColor.black), //لون النص الي يظهر فوق
//           border:  OutlineInputBorder(
//               borderRadius: BorderRadius.circular(120),
      
          
//               ),
      
//           focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(120),
//               // حدود الاطار عندما نكتب داخلة
//               borderSide: const BorderSide(
//                 color: AppColor.brown,
//               )),
//           enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(120),
//               // تفعيل اطار التكست
//               borderSide: const BorderSide(
                 
//                    color: AppColor.brown,
//                   )),
      
//           labelText: widget.hint, //النص الي يظهر داخل التكست
//           floatingLabelAlignment: FloatingLabelAlignment.center,
//           // اظهار النص وسط التكست عند الكتابة فوقة
//           prefixIcon: widget.isPassword
//               ? IconButton(
//                   onPressed: () {
//                     setState(() {
//                       _obscureText = !_obscureText;
//                     });
//                   },
//                   icon: _obscureText
//                       ? Icon(
//                           Icons.visibility_off,
//                           color: Theme.of(context).primaryColor,
//                         )
//                       : Icon(
//                           Icons.remove_red_eye_outlined,
//                           color: Theme.of(context).primaryColor,
//                         ))
//               : Icon(
//                   widget.icon,
//                   color: AppColor.brown,
//                 ),
//         ),
//         keyboardType: widget.isPhone ? TextInputType.number : TextInputType.text,
//       ),
//     );
//   }

// }
