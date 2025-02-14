class CheckoutModel {
  String status;
  CheckoutData data;
  String message;
  int orderId;
  int code;

  CheckoutModel({
    required this.status,
    required this.data,
    required this.message,
    required this.orderId,
    required this.code,
  });

  factory CheckoutModel.fromJson(Map<String, dynamic> json) {
    return CheckoutModel(
      status: json['status'],
      data: CheckoutData.fromJson(json['data']),
      message: json['message'],
      orderId: json['order_id'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.toJson(),
      'message': message,
      'order_id': orderId,
      'code': code,
    };
  }
}

class CheckoutData {
  List<CartItem> cartItems;
  String subtotal;
  String deliveryFee;
  String totalAmount;
  String deliveryAddress;

  CheckoutData({
    required this.cartItems,
    required this.subtotal,
    required this.deliveryFee,
    required this.totalAmount,
    required this.deliveryAddress,
  });

  factory CheckoutData.fromJson(Map<String, dynamic> json) {
    var cartItemsList = json['cart_items'] as List;
    List<CartItem> cartItems =
        cartItemsList.map((item) => CartItem.fromJson(item)).toList();

    return CheckoutData(
      cartItems: cartItems,
      subtotal: json['subtotal'],
      deliveryFee: json['delivery_fee'],
      totalAmount: json['total_amount'],
      deliveryAddress: json['delivery_address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cart_items': cartItems.map((item) => item.toJson()).toList(),
      'subtotal': subtotal,
      'delivery_fee': deliveryFee,
      'total_amount': totalAmount,
      'delivery_address': deliveryAddress,
    };
  }
}

class CartItem {
  int productDetailsId;
  String productDetailsName;
  String categoryName;
  String subcategoryName;
  int variantId;
  int quantity;
  String price;
  String subtotal;

  CartItem({
    required this.productDetailsId,
    required this.productDetailsName,
    required this.categoryName,
    required this.subcategoryName,
    required this.variantId,
    required this.quantity,
    required this.price,
    required this.subtotal,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productDetailsId: json['product_details_id'],
      productDetailsName: json['product_details_name'],
      categoryName: json['category_name'],
      subcategoryName: json['subcategory_name'],
      variantId: json['variant_id'],
      quantity: json['quantity'],
      price: json['price'],
      subtotal: json['subtotal'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_details_id': productDetailsId,
      'product_details_name': productDetailsName,
      'category_name': categoryName,
      'subcategory_name': subcategoryName,
      'variant_id': variantId,
      'quantity': quantity,
      'price': price,
      'subtotal': subtotal,
    };
  }
}
