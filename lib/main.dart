// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yemen_aqar/bindings/intialbindings.dart';
import 'package:yemen_aqar/routes.dart';

import 'utils/services/my_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initialServices(); // تهيئة الخدمات

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // debugShowCheckedModeBanner: false,
      locale: const Locale('ar'), // تحديد اللغة الافتراضية إلى العربية
      fallbackLocale: const Locale('ar'), // استخدام العربية كخيار افتراضي
      theme: ThemeData(
        fontFamily: "modern",
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontFamily: "modern", fontSize: 24),
          titleMedium: TextStyle(fontFamily: "modern", fontSize: 20),
          titleSmall: TextStyle(fontFamily: "modern", fontSize: 16),
        ),
      ),
      initialRoute: '/SplashScreen', // جعل SplashScreen هي الصفحة الأولى

      getPages: AppRoutes.routes,
      initialBinding: InitialBindings(),

      routingCallback: (routing) {
        // إضافة Middleware
        // MyMiddleWare();
      },
    );
  }
}
