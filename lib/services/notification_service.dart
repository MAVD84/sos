import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/notification_model.dart';

class NotificationService {
  static const String _notificationsKey = 'notifications';

  Future<void> saveNotification(NotificationModel notification) async {
    final prefs = await SharedPreferences.getInstance();
    final notifications = await loadNotifications();
    notifications.add(notification);
    final encodedNotifications = notifications
        .map((n) => json.encode(n.toMap()))
        .toList();
    await prefs.setStringList(_notificationsKey, encodedNotifications);
  }

  Future<List<NotificationModel>> loadNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedNotifications = prefs.getStringList(_notificationsKey) ?? [];
    return encodedNotifications
        .map((encoded) => NotificationModel.fromMap(json.decode(encoded)))
        .toList();
  }

  Future<void> deleteNotification(String notificationId) async {
    final prefs = await SharedPreferences.getInstance();
    final notifications = await loadNotifications();
    notifications.removeWhere((n) => n.id == notificationId);
    final encodedNotifications = notifications
        .map((n) => json.encode(n.toMap()))
        .toList();
    await prefs.setStringList(_notificationsKey, encodedNotifications);
  }

  Future<void> clearAllNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_notificationsKey);
  }
}
