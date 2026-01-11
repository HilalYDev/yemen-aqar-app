import 'package:flutter/material.dart';

import '../../../../common/widgets/texts/text_styles.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppTextStyles(
          title: "سياسة الخصوصية",
          mediumSize: true,
        ),
        centerTitle: true, // لتوسيط عنوان الـ AppBar
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // إضافة padding حول النص
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // محاذاة النص لليسار
          children: [
            const Text(
              "مرحبًا بكم في سياسة الخصوصية الخاصة بتطبيقنا.",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16), // مسافة بين الفقرات
            const Text(
              "نحن نحرص على خصوصيتك ونلتزم بحماية بياناتك الشخصية. توضح هذه السياسة كيفية جمعنا واستخدامنا لمعلوماتك.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              "1. المعلومات التي نجمعها:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "قد نجمع معلومات مثل الاسم، البريد الإلكتروني، رقم الهاتف، وغيرها من المعلومات التي تقدمها لنا عند التسجيل أو استخدام التطبيق.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              "2. كيفية استخدام المعلومات:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "نستخدم المعلومات لتحسين تجربة المستخدم، تخصيص المحتوى، والرد على استفساراتك.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              "3. مشاركة المعلومات:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "لا نشارك معلوماتك مع أطراف ثالثة إلا في حالات محدودة مثل الالتزام بالقوانين أو حماية حقوقنا.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              "4. حماية المعلومات:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "نستخدم إجراءات أمنية متقدمة لحماية معلوماتك من الوصول غير المصرح به.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              "5. التغييرات على السياسة:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "قد نقوم بتحديث هذه السياسة من وقت لآخر. ننصحك بمراجعتها بشكل دوري.",
              style: TextStyle(fontSize: 16),
            ),
            RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  TextSpan(text: "لمزيد من المعلومات، يمكنك زيارة "),
                  TextSpan(
                    text: "موقعنا الإلكتروني",
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    // يمكنك إضافة رابط هنا
                  ),
                  TextSpan(text: "."),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
