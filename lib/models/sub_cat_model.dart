class SubCatModel {
  String status;
  List<Data> data;
  String message;
  int code;

  SubCatModel({required this.status, required this.data, required this.message, required this.code});

  factory SubCatModel.fromJson(Map<String, dynamic> json) {
    return SubCatModel(
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
  final int id;
  final String subcategoryName;
  final String image;

  Data({
    required this.id,
    required this.subcategoryName,
    required this.image,
  });

  // Factory constructor to create a SubCategory instance from a JSON map
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      subcategoryName: json['subcategory_name'],
      image: json['subcategory_img'],
    );
  }

  // Method to convert a SubCategory instance into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subcategory_name': subcategoryName,
      'subcategory_img': image,
    };
  }
}
