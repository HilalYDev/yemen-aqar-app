import 'package:get/get.dart';
import 'package:yemen_aqar/features/Yemen_Aqar/screens/navigation_menu/navigation_menu.dart';
import 'package:yemen_aqar/features/authentication/screens/account_status/account_expired_screen.dart';
import 'package:yemen_aqar/features/authentication/screens/account_status/account_not_active_screen.dart';
import 'package:yemen_aqar/features/authentication/screens/auth/auth_screen.dart';
import 'package:yemen_aqar/features/authentication/screens/auth/forgetpassword/forgot_password_screen.dart';
import 'package:yemen_aqar/features/authentication/screens/auth/verification_screen.dart';

import 'features/Yemen_Aqar/screens/property/property_screen.dart';
import 'property_browse_screen.dart';
import 'splash_screen.dart';
import 'features/Yemen_Aqar/screens/property/property_add_screen.dart';
import 'features/Yemen_Aqar/screens/property/property_edit_screen.dart';
import 'features/authentication/screens/auth/forgetpassword/reset_password_screen.dart';
import 'features/authentication/screens/auth/sign_up_screen.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: '/SplashScreen', // مسار TestScreens
      page: () => const SplashScreen(),
    ),

    // GetPage(name: '/TestView', page: () => const TestView()),
    GetPage(name: '/AuthScreen', page: () => const AuthScreen()),
    GetPage(name: '/signup', page: () => const SignUpScreen()),
    GetPage(name: '/verification', page: () => const VerificationScreen()),
    GetPage(name: '/phone', page: () => const ForgotPasswordScreen()),
    GetPage(name: '/NavigationMenu', page: () => const NavigationMenu()),
    GetPage(name: '/resetPassword', page: () => const ResetPasswordScreen()),
    GetPage(
      name: '/AccountNotActiveScreen',
      page: () => const AccountNotActiveScreen(),
    ),
    GetPage(
      name: '/AccountExpiredScreen',
      page: () => const AccountExpiredScreen(),
    ),
    // GetPage(
    //   name: '/OfficeDetailsScreen',
    //   page: () => const OfficeDetailsScreen(),
    // ),
    GetPage(name: '/PropertyScreen', page: () => const PropertyScreen()),
    // GetPage(
    // name: '/OfficePropertiesScreen',
    // page: () => const OfficePropertiesScreen()),
    GetPage(name: '/PropertyAddScreen', page: () => const PropertyAddScreen()),
    GetPage(
      name: '/EditPropertyScreen',
      page: () => const PropertyEditScreen(),
    ),

    GetPage(
      name: '/BrowsePropertiesScreen',
      page: () => const BrowsePropertiesScreen(),
    ),
  ];
}
