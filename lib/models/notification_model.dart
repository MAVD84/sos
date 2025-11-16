import 'dart:convert';

class NotificationModel {
  final String id;
  final String title;
  final String body;
  final DateTime receivedDate;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.receivedDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'receivedDate': receivedDate.toIso8601String(),
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      receivedDate: DateTime.parse(map['receivedDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source));
}
