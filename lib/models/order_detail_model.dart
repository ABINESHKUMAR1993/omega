class OrderDetailsModel {
  String status;
  OrderData data;
  String message;
  int code;

  OrderDetailsModel({
    required this.status,
    required this.data,
    required this.message,
    required this.code,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailsModel(
      status: json['status'],
      data: OrderData.fromJson(json['data']),
      message: json['message'],
      code: json['code'],
    );
  }
}

class OrderData {
  List<OrderItem> orderItems;
  dynamic subtotal;
  dynamic deliveryFee;
  dynamic totalAmount;

  OrderData({
    required this.orderItems,
    required this.subtotal,
    required this.deliveryFee,
    required this.totalAmount,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      orderItems: (json['order_items'] as List)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
      subtotal: json['subtotal'],
      deliveryFee: json['delivery_fee'],
      totalAmount: json['total_amount'],
    );
  }
}

class OrderItem {
  String billId;
  int userId;
  String userName;
  String deliveryAddress;
  String? instruction;
  String status;
  DateTime orderDate;
  List<Product> products;

  OrderItem({
    required this.billId,
    required this.userId,
    required this.userName,
    required this.deliveryAddress,
    this.instruction,
    required this.status,
    required this.orderDate,
    required this.products,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      billId: json['Bill Id'],
      userId: json['user_id'],
      userName: json['user_name'],
      deliveryAddress: json['delivery_address'],
      instruction: json['instruction'],
      status: json['status'],
      orderDate: DateTime.parse(json['order_date']),
      products: (json['products'] as List)
          .map((item) => Product.fromJson(item))
          .toList(),
    );
  }
}

class Product {
  String productId;
  String productName;
  int quantity;
  dynamic amount;

  Product({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.amount,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['product_details_id'],
      productName: json['product_details_name'],
      quantity: json['quantity'],
      amount: json['amount'],
    );
  }
}
