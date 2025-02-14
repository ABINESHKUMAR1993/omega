class ProductDetailModel {
  final String status;
  final ProductData data;
  final String message;
  final int code;

  ProductDetailModel({
    required this.status,
    required this.data,
    required this.message,
    required this.code,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      status: json['status'],
      data: ProductData.fromJson(json['data']),
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

class ProductData {
  final int id;
  final int categoryId;
  final String categoryName;
  final String? subcategoryName;
  final String title;
  final String description;
  final String image;
  final String brand;
  final String package;
  bool isWishlist;
  final List<Variation> variation;

  ProductData({
    required this.id,
    required this.categoryId,
    required this.categoryName,
    this.subcategoryName,
    required this.title,
    required this.description,
    required this.image,
    required this.brand,
    required this.package,
    required this.isWishlist,
    required this.variation,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    var variationList = (json['variations'] as List)
        .map((item) => Variation.fromJson(item))
        .toList();

    return ProductData(
      id: json['id'],
      categoryId: json['category_id'],
      categoryName: json['category_name'],
      subcategoryName: json['subcategory_name'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      brand: json['brand'],
      package: json['package'],
      isWishlist: json['is_wishlist'],
      variation: variationList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'category_name': categoryName,
      'subcategory_name': subcategoryName,
      'title': title,
      'description': description,
      'image': image,
      'brand': brand,
      'package': package,
      'is_wishlist': isWishlist,
      'variations': variation.map((v) => v.toJson()).toList(),
    };
  }

  void toggleFavorite() {
    isWishlist = !isWishlist;
  }
}

class Variation {
  final int productId;
  final int varId;
  final String unit;
  final String? price;
  final String mrp;
  final String discount;

  Variation({
    required this.productId,
    required this.unit,
    required this.varId,
    required this.price,
    required this.mrp,
    required this.discount,
  });

  factory Variation.fromJson(Map<String, dynamic> json) {
    return Variation(
      varId: json['variant_id'],
      productId: json['product_id'],
      unit: json['unit'],
      price: json['price'],
      mrp: json['mrp'],
      discount: json['discount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'variant_id':varId,
      'product_id': productId,
      'unit': unit,
      'price': price,
      'mrp': mrp,
      'discount': discount,
    };
  }
}
