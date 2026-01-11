import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:yemen_aqar/utils/constants/app_colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants/imgaeasset.dart';
import 'statusrequest.dart';

class HandlingDataView extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  const HandlingDataView({
    super.key,
    required this.statusRequest,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.offlinefailure
        ? Center(
            child: Lottie.asset(AppImageAsset.offline, width: 250, height: 250),
          )
        : statusRequest == StatusRequest.serverfailure
        ? Center(
            child: Lottie.asset(AppImageAsset.server, width: 250, height: 250),
          )
        : statusRequest == StatusRequest.failure
        ? Center(
            child: Lottie.asset(
              AppImageAsset.noData,
              width: 250,
              height: 250,
              repeat: true,
            ),
          )
        : widget;
  }
}

class HandlingDataRequest extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget? widgetLoading; // ويدجت مخصصة للتحميل
  final Widget widget;

  const HandlingDataRequest({
    super.key,
    required this.statusRequest,
    this.widgetLoading,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    if (statusRequest == StatusRequest.loading) {
      return Center(
        child:
            widgetLoading ??
            BlurryModalProgressHUD(
              inAsyncCall: true,
              blurEffectIntensity: 4,
              progressIndicator: const SpinKitFadingCircle(
                color: AppColors.black,
                size: 90.0,
              ),
              dismissible: false,
              opacity: 0.4,
              child: widget, // لف الـ widget بدون Scaffold
            ),
      );
    }

    if (statusRequest == StatusRequest.offlinefailure) {
      return Center(
        child: Lottie.asset(AppImageAsset.offline, width: 250, height: 250),
      );
    }

    if (statusRequest == StatusRequest.serverfailure) {
      return Center(
        child: Lottie.asset(AppImageAsset.server, width: 250, height: 250),
      ); // فشل الخادم
    }

    if (statusRequest == StatusRequest.failure) {
      return Center(
        child: Lottie.asset(
          AppImageAsset.noData,
          width: 250,
          height: 250,
          repeat: true,
        ),
      ); // لا توجد بيانات
    }
    if (statusRequest == StatusRequest.noData) {
      return Center(
        child: Lottie.asset(
          AppImageAsset.noData,
          width: 250,
          height: 250,
          repeat: true,
        ),
      ); // لا توجد بيانات
    }

    return widget; // عرض الواجهة الرئيسية
  }
}
