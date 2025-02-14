class CategoryModel {
  String status;
  List<Data> data;
  String message;
  int code;

  CategoryModel(
      {required this.status,
      required this.data,
      required this.message,
      required this.code});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
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
  String? catName;
  String? subCatName;
  String? image;

  Data({this.id, this.catName, this.subCatName, this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catName = json['category_name'];
    subCatName = json['subcategory_name'];
    image = json['category_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_name'] = catName;
    data['subcategory_name'] = subCatName;
    data['category_img'] = image;

    return data;
  }
}
