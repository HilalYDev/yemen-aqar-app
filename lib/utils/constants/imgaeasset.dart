class AppImageAsset {
  static const String rootImages = "assets/images";
  static const String rootLottie = "assets/lottie";
  static const String loading = "$rootLottie/loading.json";
  static const String offline = "$rootLottie/offline.json";
  static const String noData = "$rootLottie/nodata.json";
  static const String server = "$rootLottie/server.json";
  static const String logoH = "$rootImages/logoH.png";
  static const String logoV = "$rootImages/logoV.png";

  // ==============================ICONS=============================================
  static const String icons = "assets/icons";
  static const String notifications = "$icons/Notifications.png";

  //=====================================TEST=======================================================
  static const String test = "$rootImages/test.jpg";
  static const String test1 = "$rootImages/test1.jpg";
  static const String raunak = "$rootImages/raunak.jpg";
  //=====================================carousel_slider=======================================================
  static const String carouselslider = "assets/carousel_slider";

  static const String carouselslider1 = "$carouselslider/apartment_rent.jpeg";
  static const String carouselslider2 = "$carouselslider/apartment_sale.jpeg";
  static const String carouselslider3 = "$carouselslider/house3.jpg";

  //=====================================propertiesForSale=======================================================
  static const String propertiesForSale1 =
      "$carouselslider/property_types/villa_sale_1.jpeg";
  static const String propertiesForSale2 =
      "$carouselslider/property_types/apartment_sale_4.jpeg";
  static const String propertiesForSale3 =
      "$carouselslider/property_types/land_sale_3.jpeg";
  static const String propertiesForSale4 =
      "$carouselslider/property_types/apartment_rent_1.jpeg";
  static const String propertiesForSale5 =
      "$carouselslider/property_types/villa_rent_3.jpeg";
}

final List<String> imgList = [
  AppImageAsset.carouselslider1,
  AppImageAsset.carouselslider2,
  AppImageAsset.carouselslider3,
];
final List<String> propertiesForSale = [
  AppImageAsset.propertiesForSale1,
  AppImageAsset.propertiesForSale2,
  AppImageAsset.propertiesForSale3,
  AppImageAsset.propertiesForSale4,
  AppImageAsset.propertiesForSale5,
];
