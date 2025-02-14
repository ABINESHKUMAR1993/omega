class AddressModel {
  String status;
  List<Data> data;
  String message;
  int code;

  AddressModel(
      {required this.status,
      required this.data,
      required this.message,
      required this.code});

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
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
  final int userId;
  final String houseNo;
  final String roadName;
  final String landmark;
  final String district;
  final String state;
  final String pin;
  final bool isCurrent;
  final DateTime createdAt;
  final DateTime updatedAt;

  Data({
    required this.id,
    required this.userId,
    required this.houseNo,
    required this.roadName,
    required this.landmark,
    required this.district,
    required this.state,
    required this.pin,
    required this.isCurrent,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      userId: json['user_id'],
      houseNo: json['house_no'],
      roadName: json['road_name'],
      landmark: json['landmark'],
      district: json['district'],
      state: json['state'],
      pin: json['pin'],
      isCurrent: json['is_current'] == 1,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'house_no': houseNo,
      'road_name': roadName,
      'landmark': landmark,
      'district': district,
      'state': state,
      'pin': pin,
      'is_current': isCurrent ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
