import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/standalone.dart';

class NotificationController extends GetxController {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> configureNotification(
      int id, String text, String isImportant, TZDateTime time) async {
    final now = DateTime.now();
    if (time.isAfter(now)) {
      addNotification(
        id: id,
        title: text,
        body: isImportant,
        endTime: time, //Add this
        channel: "live",
      );
    }
  }

  Future<void> addNotification({
    required int id,
    required String title,
    required String body,
    required TZDateTime endTime,
    required String channel,
  }) async {
    final androidDetail = AndroidNotificationDetails(
      channel,
      channel,
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
      channelShowBadge: true,
    );

    final noticeDetail = NotificationDetails(
      iOS: null,
      android: androidDetail,
    );

    flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body.toLowerCase(),
      endTime,
      noticeDetail,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }
}
