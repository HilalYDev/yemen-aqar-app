import 'package:flutter/material.dart';

import '../../../../common/widgets/auth/auth_page.dart';
import 'login_screen.dart';
import 'sign_up_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthPage(
      length: 2,
      tabs: [Tab(text: "تسجيل الدخول"), Tab(text: "إنشاء حساب")],
      tabViews: [LoginScreen(), SignUpScreen()],
    );
  }
}
