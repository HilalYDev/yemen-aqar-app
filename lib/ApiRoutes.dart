// ignore_for_file: file_names

class ApiRoutes {
  static const String baseUrl = "http://192.168.8.2/yemen_aqar/api";
  // static const String baseUrl = "http://localhost/yemen_aqar/api";

  // 🟢 مسارات المستخدمين
  static const String userregister = "$baseUrl/users/register";
  static const String verifyPhone = "$baseUrl/users/verifyPhone";
  static const String userlogin = "$baseUrl/users/login";
  static const String checkPhone = "$baseUrl/users/checkPhone";
  static const String resetPassword = "$baseUrl/users/resetPassword";
  static const String resendVerificationCode =
      "$baseUrl/users/resendVerificationCode1";
  static const String getUserData = "$baseUrl/users/getUserData";

  // 🟠 مسارات تصنيفات العقارات
  static const String propCatIndex = "$baseUrl/property-categories/index";
  static const String propCatShow = "$baseUrl/property-categories/show";
  static const String propCatStore = "$baseUrl/property-categories/store";
  static const String propCatUpdate = "$baseUrl/property-categories/update";
  static const String propCatDelete = "$baseUrl/property-categories/destroy";

  // 🔵 مسارات أنواع العقارات
  static const String propTypeIndex = "$baseUrl/property-types/index";
  static const String propTypeShow = "$baseUrl/property-types/show";
  static const String propTypeStore = "$baseUrl/property-types/store";
  static const String propTypeUpdate = "$baseUrl/property-types/update";
  static const String propTypeDelete = "$baseUrl/property-types/destroy";

  // 🟣 مسارات العقارات
  static const String propertyIndex = "$baseUrl/properties/index";
  static const String propertyShow = "$baseUrl/properties/show";
  static const String propertyStore = "$baseUrl/properties/store";
  static const String propertyUpdate = "$baseUrl/properties/update";
  static const String propertyDelete = "$baseUrl/properties/destroy";

  // 🔍 مسارات البحث
  static const String search = "$baseUrl/search/search";

  // 🔵 مسارات السلة
  static const String cartIndex = "$baseUrl/cart/index"; // جلب عناصر السلة
  static const String cartShow = "$baseUrl/cart/show";
  static const String cartStore = "$baseUrl/cart/store";
  static const String cartUpdate = "$baseUrl/cart/update";
  static const String cartDelete = "$baseUrl/cart/destroy";

  // 🔵 مسارات الطلبات
  static const String orderCheckout = "$baseUrl/orders/checkout";
  static const String orderIndex = "$baseUrl/orders/index";
  static const String orderShow = "$baseUrl/orders/show";
  static const String orderUsers = "$baseUrl/orders/userOrders";
}




// class AppLink {
//   // http://192.168.61.96/yemen_aqar/api/property-categories/show
//   static const String server = "http://192.168.61.96/yemen_aqar/api";
 
// // ================================= Test ========================== //
//   static const String testAdd = "$server/Test/add.php";
//   static const String testRemove = "$server/Test/remove.php";
//   static const String testView = "$server/Test/view.php";
// // ================================= Auth ========================== //

//   static const String signUp = "$server/auth/signup.php";
//   static const String login = "$server/auth/login.php";
//   static const String verifycodessignup = "$server/auth/verfiycode.php";
//   static const String resend = "$server/auth/resend.php";
//   static const String users = "$server/auth/users.php";
//   static const String updateusers = "$server/auth/updateusers.php";
//   static const String imgesusers = "$server/auth/imgesusers.php";
// // ================================= ForgetPassword ========================== //

//   static const String checkEmail = "$server/forgetpassword/checkemail.php";
//   static const String resetPassword =
//       "$server/forgetpassword/resetpassword.php";
//   static const String verifycodeforgetpassword =
//       "$server/forgetpassword/verifycode.php";

// // Home

// // ================================= property-categories ========================== //

//   static const String PCindex = "$server/property-categories/index";
//   static const String PCshow  = "$server/property-categories/show";


// // Favorite

//   static const String favoriteAdd = "$server/favorite/add.php";
//   static const String favoriteRemove = "$server/favorite/remove.php";
//   static const String favoriteView = "$server/favorite/view.php";
//   static const String deletefromfavroite =
//       "$server/favorite/deletefromfavroite.php";

//   // Cart
//   static const String cartview = "$server/cart/view.php";
//   static const String cartadd = "$server/cart/add.php";
//   static const String cartdelete = "$server/cart/delete.php";
//   static const String cartgetcountitems = "$server/cart/getcountitems.php";

//   // Address

//   static const String addressView = "$server/address/view.php";
//   static const String addressAdd = "$server/address/add.php";
//   static const String addressEdit = "$server/address/edit.php";
//   static const String addressDelete = "$server/address/delete.php";

//   // Coupon

//   static const String checkcoupon = "$server/coupon/checkcoupon.php";
//   static const String viewcoupon = "$server/coupon/viewcoupon.php";

//   // Checkout

//   static const String checkout = "$server/orders/checkout.php";
//   static const String countitems = "$server/orders/countitems.php";
//   static const String pendingorders = "$server/orders/pending.php";
//   static const String ordersarchive = "$server/orders/archive.php";
//   static const String ordersdetails = "$server/orders/details.php";
//   static const String ordersdelete = "$server/orders/delete.php";
//   // ================================= Notification ========================== //

//   static const String notification = "$server/notification.php";
// }
