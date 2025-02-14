class OrdersModel {
  String? status;
  List<Data> data;
  String? message;
  int? code;

  OrdersModel({required this.status, required this.data, required this.message, required this.code});

  factory OrdersModel.fromJson(Map<String, dynamic> json) {
    return OrdersModel(
      status: json['status'],
      data: List<Data>.from(
        json['data'].map((item) => Data.fromJson(item)),
      ),
      message: json['message'],
      code: json['code'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': List<dynamic>.from(data.map((item) => item.toJson())),
      'message': message,
      'code': code,
    };
  }
}






class Data {
  final String? billId;
  final String? userId;
  final String? userName;
  final String? productDetailsId;
  final String? productDetailsName;
  final String? categoryName;
  final String? subcategoryName;
  final String? quantity;
  final String? amount;
  final String? deliveryAddress;
  final String? instruction;
  final String? status;
  final DateTime orderDate;

  Data({
    required this.billId,
    required this.userId,
    required this.userName,
    required this.productDetailsId,
    required this.productDetailsName,
    required this.categoryName,
    required this.subcategoryName,
    required this.quantity,
    required this.amount,
    required this.deliveryAddress,
    this.instruction,
    required this.status,
    required this.orderDate,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      billId: json['bill_id'],
      userId: json['user_id'],
      userName: json['user_name'],
      productDetailsId: json['product_details_id'],
      productDetailsName: json['product_details_name'],
      categoryName: json['category_name'],
      subcategoryName: json['subcategory_name'],
      quantity: json['quantity'],
      amount: json['amount'],
      deliveryAddress: json['delivery_address'],
      instruction: json['instruction'],
      status: json['status'],
      orderDate: DateTime.parse(json['order_date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bill_id': billId,
      'user_id': userId,
      'user_name': userName,
      'product_details_id': productDetailsId,
      'product_details_name': productDetailsName,
      'category_name': categoryName,
      'subcategory_name': subcategoryName,
      'quantity': quantity,
      'amount': amount,
      'delivery_address': deliveryAddress,
      'instruction': instruction,
      'status': status,
      'order_date': orderDate.toIso8601String(),
    };
  }
}
