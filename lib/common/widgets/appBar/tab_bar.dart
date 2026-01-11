// import 'package:flutter/material.dart';
// import '../../utils/constants/color.dart';
// import '../../utils/device/device_utility.dart';
// import '../../utils/helpers/helper_functions.dart';

// class TTabBar extends StatelessWidget implements PreferredSizeWidget {
//   const TTabBar({super.key, required this.tab});
//   final List<Widget> tab;

//   @override
//   Widget build(BuildContext context) {
//     final dark = THelperFunctions.isDarkMode(context);
//     return Material(
//       child: TabBar(
//         tabs: tab,
//         tabAlignment: TabAlignment.start,
//         isScrollable: true,
//         indicatorColor: AppColors.primary,
//         labelColor: dark ? AppColors.white : AppColors.primary,
//         unselectedLabelColor: AppColors.darkGrey,
//       ),
//     );
//   }

//   @override
//   Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
// }
