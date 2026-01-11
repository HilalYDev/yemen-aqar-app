import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yemen_aqar/features/Yemen_Aqar/screens/navigation_menu/navigation_menu_screens/all_categories_screen.dart';

import '../screens/cart/cart_screen.dart';
import '../screens/orders/orders_screen.dart';

class NavigationController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>(); // 🔹 مفتاح التحكم في Drawer

  int currentpage = -1;

  List<Widget> listPage = [
    const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Center(child: Text("Profile"))],
    ),
    // InkWell(
    //   onTap: () {
    //     Get.to(() => const
    //   },
    // ),
    // const SearchScreen(),
    OrdersScreen(),
    CartScreen(),
    const AllCategoriesScreen(),
    // const Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [Center(child: Text("الأقسام"))], // تم تعديل النص هنا
    // ),
  ];

  List bottomappbar = [
    {"title": "حسابي", "icon": Iconsax.user},
    // {"title": "بحث", "icon": Iconsax.search_normal},
    {"title": "الطلبات", "icon": Iconsax.receipt},
    {"title": "السلة", "icon": Iconsax.shopping_cart},

    {
      "title": "الأقسام",
      "icon": Iconsax.category,
    }, // تم تعديل الأيقونة إلى أيقونة الأقسام
  ];

  // void changePage(int i) {
  //   if (i == 0) {
  //     // 🔹 إذا ضغط على زر Profile، افتح الـ Drawer
  //     scaffoldKey.currentState?.openDrawer();
  //   } else {
  //     currentpage = i;
  //     update();
  //   }
  // }
  void changePage(int i) {
    if (i == 0) {
      // 🔹 إذا ضغط على زر Profile، افتح الـ Drawer
      scaffoldKey.currentState?.openDrawer();
    } else {
      if (currentpage != -1) {
        // 🔹 حذف الـ Controller عند الانتقال بين الصفحات
        // Get.delete<SearchDataController>(); // ضع هنا اسم الـ Controller المناسب
      }
      currentpage = i;
      update();
    }
  }
}
