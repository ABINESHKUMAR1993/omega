class ProductModel {
  String status;
  List<Data> data;
  String message;
  int code;

  ProductModel(
      {required this.status,
      required this.data,
      required this.message,
      required this.code});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
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
  int? id;
  int? catId;
  String? catName;
  String? subCatName;
  String? title;
  String? description;
  String? image;
  String? brand;
  String? package;
  bool? isWishlist;
  List<Variation>? variation;

  Data(
      {this.id,
      this.catName,
      this.subCatName,
      this.variation,
      this.title,
      this.catId,
      this.description});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catId = json['category_id'];
    catName = json['category_name'];
    subCatName = json['subcategory_name'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    brand = json['brand'];
    package = json['package'];
    isWishlist = json['is_wishlist'];
    if (json['variations'] != null) {
      variation = List<Variation>.from(
          json['variations'].map((item) => Variation.fromJson(item)));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_id'] = catId;
    data['category_name'] = catName;
    data['subcategory_name'] = subCatName;
    data['title'] = title;
    data['description'] = description;
    data['image'] = image;
    data['brand'] = brand;
    data['package'] = package;
    data['is_wishlist'] = isWishlist;
    if (variation != null) {
      data['variations'] =
          List<dynamic>.from(variation!.map((item) => item.toJson()));
    }

    return data;
  }

  void toggleFavorite() {
    isWishlist = isWishlist!;
  }
}

class Variation {
  // Define the properties for the Detail class
  int? varId;
  int? proId;
  String? unit;
  String? price;
  String? mrp;
  String? dis;

  Variation(
      {this.unit, this.price, this.dis, this.mrp, this.varId, this.proId});

  factory Variation.fromJson(Map<String, dynamic> json) {
    return Variation(
      unit: json['unit'],
      price: json['price'],
      mrp: json['mrp'],
      dis: json['discount'],
      varId: json['variant_id'],
      proId: json['product_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'unit': unit,
      'price': price,
      'mrp': mrp,
      'discount': dis,
      'variant_id': varId,
      'product_id': proId
    };
  }
}
