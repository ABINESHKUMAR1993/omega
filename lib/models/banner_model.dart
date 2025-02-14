class BannerModel {
  String status;
  List<BannerData> data;
  String message;
  int code;

  BannerModel({
    required this.status,
    required this.data,
    required this.message,
    required this.code,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      status: json['status'],
      data: List<BannerData>.from(
        json['data'].map((item) => BannerData.fromJson(item)),
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

class BannerData {
  int id;
  String title;
  String image;

  BannerData({
    required this.id,
    required this.title,
    required this.image,
  });

  factory BannerData.fromJson(Map<String, dynamic> json) {
    return BannerData(
      id: json['id'],
      title: json['title'],
      image: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image_url': image,
    };
  }
}
