import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOS = DarwinInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: iOS);

    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (details) {
        print("Notification tapped with payload: ${details.payload}");
      },
    );
  }

  // Future<void> showNotification({
  //   required int id,
  //   required String title,
  //   required String body,
  //   String? payload,
  // }) async {
  //   const androidDetails = AndroidNotificationDetails(
  //     'channel_id',
  //     'channel_name',
  //     channelDescription: 'channel_description',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //   );
  //   const iOSDetails = DarwinNotificationDetails();
  //   const details = NotificationDetails(
  //     android: androidDetails,
  //     iOS: iOSDetails,
  //   );
  //   await _notifications.show(id, title, body, details, payload: payload);
  // }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
    String? imageUrl, // يمكنك تمرير صورة اختيارية
  }) async {
    // إعداد نمط Big Picture لو فيه صورة
    final bigPictureStyle = imageUrl != null
        ? BigPictureStyleInformation(
            FilePathAndroidBitmap(imageUrl),
            contentTitle: title,
            summaryText: body,
          )
        : BigTextStyleInformation(body, contentTitle: title, summaryText: body);

    final androidDetails = AndroidNotificationDetails(
      'main_channel',
      'General Notifications',
      channelDescription: 'App local notifications',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      color: const Color(0xFF00796B),
      icon: '@mipmap/ic_launcher',
      styleInformation: bigPictureStyle,
      largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      actions: [
        const AndroidNotificationAction('open', 'فتح التطبيق'),
        const AndroidNotificationAction('dismiss', 'إخفاء'),
      ],
    );

    const iOSDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails,
    );

    await _notifications.show(id, title, body, details, payload: payload);
  }
}
