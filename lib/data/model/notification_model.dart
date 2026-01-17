class NotificationModel {
  final String userId;
  final String title;
  final String body;
  final DateTime ? createdAt;

  NotificationModel({
    required this.title,
    required this.body,
     this.createdAt,
    required this.userId,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json["title"],
      body: json["body"],
      userId: json["userId"],
      createdAt: (DateTime.parse(json['createdAt']))
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "body": body,
      "userId": userId,
    };
  }
}
