class NotificationModel {
  String status;
  List<NotificationData> data;
  String message;
  int code;

  NotificationModel({
    required this.status,
    required this.data,
    required this.message,
    required this.code,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      status: json['status'],
      data: List<NotificationData>.from(
        json['data'].map((item) => NotificationData.fromJson(item)),
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

class NotificationData {
  int id;
  String title;
  String content;
  String? date;
  NotificationData({
    required this.id,
    required this.title,
    required this.content,
    required this.date
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      id: json['id'],
      title: json['title'],
      content: json['content'], date: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'created_at':date,
    };
  }
}
