class OrderPlaceModel {
  String status;
  OrderData data;
  String message;
  int code;

  OrderPlaceModel({
    required this.status,
    required this.data,
    required this.message,
    required this.code,
  });

  factory OrderPlaceModel.fromJson(Map<String, dynamic> json) {
    return OrderPlaceModel(
      status: json['status'],
      data: OrderData.fromJson(json['data']),
      message: json['message'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.toJson(),
      'message': message,
      'code': code,
    };
  }
}

class OrderData {
  int orderId;
  List<CartItem> cartItems;
  String deliveryAddress;
  dynamic subtotal;
  dynamic deliveryFee;
  dynamic totalAmount;

  OrderData({
    required this.orderId,
    required this.cartItems,
    required this.deliveryAddress,
    required this.subtotal,
    required this.deliveryFee,
    required this.totalAmount,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    var cartItemsList = (json['cart_items'] as List)
        .map((item) => CartItem.fromJson(item))
        .toList();
    return OrderData(
      orderId: json['order_id'],
      cartItems: cartItemsList,
      deliveryAddress: json['delivery_address'],
      subtotal: json['subtotal'],
      deliveryFee: json['delivery_fee'],
      totalAmount: json['total_amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'cart_items': cartItems.map((item) => item.toJson()).toList(),
      'delivery_address': deliveryAddress,
      'subtotal': subtotal,
      'delivery_fee': deliveryFee,
      'total_amount': totalAmount,
    };
  }
}

class CartItem {
  String productDetailsId;
  String productDetailsName;
  String categoryName;
  String subcategoryName;
  int variantId;
  int quantity;
  dynamic price;

  CartItem({
    required this.productDetailsId,
    required this.productDetailsName,
    required this.categoryName,
    required this.subcategoryName,
    required this.quantity,
    required this.price,
    required this.variantId
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productDetailsId: json['product_details_id'],
      productDetailsName: json['product_details_name'],
      categoryName: json['category_name'],
      subcategoryName: json['subcategory_name'],
      quantity: json['quantity'],
      price: json['price'], variantId: json['variant_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_details_id': productDetailsId,
      'product_details_name': productDetailsName,
      'category_name': categoryName,
      'subcategory_name': subcategoryName,
      'quantity': quantity,
      'price': price,
      'variant_id':variantId
    };
  }
}
