class ProfileModel {
  String status;
  String msg;
  Data? data;
  int code;

  ProfileModel({
    required this.status,
    required this.msg,
    this.data,
    required this.code,
  });

  ProfileModel.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        msg = json['message'],
        code = json['code'],
        data = json['data'] != null ? Data.fromJson(json['data']) : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = msg;
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  String userId;
  String name;
  String email;
  String phoneNumber;
  String? profileImage;

  Data({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.profileImage,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user id'] ?? '',
        name = json['name'] ?? '',
        email = json['email'] ?? '',
        phoneNumber = json['phone_number'] ?? '',
        // Check if 'profile_image' is a string; otherwise, set it to null
        profileImage =
            json['profile_image'] is String ? json['profile_image'] : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user id'] = userId;
    data['name'] = name;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['profile_image'] = profileImage;
    return data;
  }
}
