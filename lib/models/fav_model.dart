class FavoritesModel {
  String status;
  List<WishlistItem> data;
  String message;
  int code;

  FavoritesModel({
    required this.status,
    required this.data,
    required this.message,
    required this.code,
  });

  factory FavoritesModel.fromJson(Map<String, dynamic> json) {
    return FavoritesModel(
      status: json['status'],
      data: List<WishlistItem>.from(
          json['data'].map((item) => WishlistItem.fromJson(item))),
      message: json['message'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.map((item) => item.toJson()).toList(),
      'message': message,
      'code': code,
    };
  }
}

class WishlistItem {
  int id;
  String userId;
  Product product;

  WishlistItem({
    required this.id,
    required this.userId,
    required this.product,
  });

  factory WishlistItem.fromJson(Map<String, dynamic> json) {
    return WishlistItem(
      id: json['id'],
      userId: json['user_id'],
      product: Product.fromJson(json['product']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'product': product.toJson(),
    };
  }
}

class Product {
  int id;
  String title;
  String description;
  String? image; // Nullable
  List<ProductVariant> variants;

  Product({
    required this.id,
    required this.title,
    required this.description,
    this.image,
    required this.variants,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'], // Can be null
      variants: List<ProductVariant>.from(
          json['variants'].map((v) => ProductVariant.fromJson(v))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'variants': variants.map((v) => v.toJson()).toList(),
    };
  }
}

class ProductVariant {
  int id;
  String title;
  String mrp;
  String discount;
  String price;

  ProductVariant({
    required this.id,
    required this.title,
    required this.mrp,
    required this.discount,
    required this.price,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    return ProductVariant(
      id: json['id'],
      title: json['title'],
      mrp: json['mrp'],
      discount: json['discount'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'mrp': mrp,
      'discount': discount,
      'price': price,
    };
  }
}
