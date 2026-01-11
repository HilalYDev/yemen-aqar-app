enum StatusRequest {
  none, // 0: لا شيء حتى الآن
  loading, // 1: جاري تحميل البيانات
  success, // 2: نجاح مع بيانات
  failure, // 3: فشل عام (مثل 404 أو حالة غير متوقعة)
  serverfailure, // 4: خطأ خادم (500, 502, …)
  offlinefailure, // 5: لا يوجد اتصال بالإنترنت
  noData, // 6: نجاح بدون بيانات
}
