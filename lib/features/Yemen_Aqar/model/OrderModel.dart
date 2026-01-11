import 'PropertyModel.dart';

class OrderModel {
  final int orderId;
  final String status;
  final double totalPrice;
  final String createdAt;
  final List<OrderItemModel> items;

  OrderModel({
    required this.orderId,
    required this.status,
    required this.totalPrice,
    required this.createdAt,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    var itemsList =
        (json['items'] as List).map((i) => OrderItemModel.fromJson(i)).toList();

    return OrderModel(
      orderId: json['order_id'],
      status: json['status'],
      totalPrice: double.tryParse(json['total_price'].toString()) ?? 0,
      createdAt: json['created_at'],
      items: itemsList,
    );
  }
}

class OrderItemModel {
  final int orderItemId;
  final int quantity;
  final PropertyModel property;

  OrderItemModel({
    required this.orderItemId,
    required this.quantity,
    required this.property,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      orderItemId: json['order_item_id'],
      quantity: json['quantity'],
      property: PropertyModel.fromJson({
        "id": json['id'],
        "name": json['name'],
        "description": json['description'],
        "image": json['image'],
        "price": json['price']?.toString(),
        "currency": json['currency'],
        "location": json['location'],
        "property_type_id": json['property_type_id']?.toString(),
        "user_id": json['user_id']?.toString(),
      }),
    );
  }
}
