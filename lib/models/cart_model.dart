class CartModel {
  String status;
  List<Data> data;
  String message;
  int code;
  int totalPrice;

  CartModel(
      {required this.status,
      required this.data,
      required this.message,
      required this.code,
      required this.totalPrice});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      totalPrice: json['total_price'],
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
      'total_price': totalPrice,
      'data': List<dynamic>.from(data.map((item) => item.toJson())),
      'message': message,
      'code': code,
    };
  }
}

class Data {
  final int id;
  final int userId;
  final int productId;
  final String title;
  final String image;
  final String categoryName;
  final String? subcategoryName;
   int quantity;
  final String price;

  Data({
    required this.id,
    required this.userId,
    required this.productId,
    required this.title,
    required this.image,
    required this.categoryName,
    this.subcategoryName,
    required this.quantity,
    required this.price,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      userId: json['user_id'],
      productId: json['product_id'],
      title: json['title'],
      image: json['image'],
      categoryName: json['category_name'],
      subcategoryName: json['subcategory_name'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'product_id': productId,
      'title': title,
      'image': image,
      'category_name': categoryName,
      'subcategory_name': subcategoryName,
      'quantity': quantity,
      'price': price,
    };
  }
}
