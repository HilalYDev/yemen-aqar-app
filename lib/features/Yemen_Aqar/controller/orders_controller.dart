import 'package:get/get.dart';
import '../../../data/dataremote/order_data.dart';
import '../../../utils/class/statusrequest.dart';
import '../../../utils/functions/handingdatacontroller.dart';
import '../../../utils/popups/toast_utils.dart';
import '../../../utils/shared_preferences/user_preferences.dart';
import '../model/OrderModel.dart';

class OrdersController extends GetxController {
  final OrderData orderData = OrderData(Get.find());

  StatusRequest statusRequest = StatusRequest.none;
  List<OrderModel> orders = [];

  @override
  void onInit() {
    fetchOrders();
    super.onInit();
  }

  Future<void> fetchOrders() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await orderData.userOrders(UserPreferences.id);
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        orders =
            (response['data'] as List)
                .map((item) => OrderModel.fromJson(item))
                .toList();

        if (orders.isEmpty) {
          statusRequest = StatusRequest.noData;
        }
      } else {
        ToastUtils.showToast(msg: response['message']);
        statusRequest = StatusRequest.failure;
      }
    }

    update();
  }
}
