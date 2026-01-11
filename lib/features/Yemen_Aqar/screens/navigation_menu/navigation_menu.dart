// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:yemen_aqar/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:yemen_aqar/features/Yemen_Aqar/screens/home/home_screen.dart';

import '../../../../common/widgets/custom_drawer/custom_drawer.dart';
import '../../../../utils/constants/app_colors.dart';

import '../../controller/navigation_controller.dart';
import 'widgets/custombottomappbarhome.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put(() => NavigationController());
    Get.put(NavigationController());

    return GetBuilder<NavigationController>(
      builder: (controller) {
        bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

        return WillPopScope(
          onWillPop: () async {
            final scaffoldState = controller.scaffoldKey.currentState;

            // ✅ إذا كان الدروار مفتوحًا، نقوم بإغلاقه فقط
            if (scaffoldState?.isDrawerOpen ?? false) {
              Navigator.of(context).pop();
              return false;
            }

            // ✅ إذا كنت في صفحة غير الرئيسية، يرجعك إليها بدل الخروج
            if (controller.currentpage != -1) {
              controller.changePage(-1);
              return false;
            }

            // ✅ إذا كنت بالفعل في الصفحة الرئيسية، يعرض رسالة تأكيد الخروج
            return await showExitConfirmation(context);
          },
          child: Scaffold(
            key: controller.scaffoldKey,
            drawer: const CustomDrawer(),
            floatingActionButton:
                isKeyboardOpen
                    ? null
                    : GestureDetector(
                      onTap: () {
                        controller.changePage(-1);
                      },
                      child: const RoundedContainer(
                        width: 60, // حجم الزر
                        height: 60, // حجم الزر
                        backgroundColor: AppColors.copperTan,
                        radius: 30,
                        showShadow: true,
                        child: Icon(
                          Icons.home_sharp,
                          size: 40,
                          color: AppColors.deepNavy,
                        ),
                      ),
                    ),
            // : FloatingActionButton(
            //     shape: const CircleBorder(),
            //     backgroundColor: AppColors.copperTan,
            //     onPressed: () {
            //       // controller.changePage(-1);
            //     },
            // child: const Icon(
            //   Icons.home_sharp,
            //   size: 40,
            //   color: AppColors.deepNavy,
            // ),
            //   ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: const CustomBottomAppBarHome(),
            body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child:
                  controller.currentpage == -1
                      ? const HomeScreen()
                      : controller.listPage.elementAt(controller.currentpage),
            ),
          ),
        );
      },
    );
  }

  Future<bool> showExitConfirmation(BuildContext context) async {
    return await showCupertinoDialog<bool>(
          context: context,
          builder:
              (context) => CupertinoAlertDialog(
                title: const Text("أغلق التطبيق"),
                content: const Text("هل تريد الخروج من التطبيق؟"),
                actions: [
                  CupertinoDialogAction(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("إلغاء"),
                  ),
                  CupertinoDialogAction(
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    child: const Text("خروج"),
                  ),
                ],
              ),
        ) ??
        false;
  }
}
