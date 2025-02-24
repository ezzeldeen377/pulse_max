import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pulse_max/features/alarm/data/models/medicine.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
 static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static StreamController<NotificationResponse> streamController =
      StreamController();
  static onTap(NotificationResponse notificationResponse) {
    streamController.add(notificationResponse);
  }

  static Future<void> init() async {
    const AndroidInitializationSettings androidInit =
        AndroidInitializationSettings('@drawable/lanuch_icon');

    const DarwinInitializationSettings iosInit = DarwinInitializationSettings();

    const InitializationSettings settings =
        InitializationSettings(android: androidInit, iOS: iosInit);

    await _notificationsPlugin.initialize(settings,
        onDidReceiveBackgroundNotificationResponse: onTap,
        onDidReceiveNotificationResponse: onTap);
    tz.initializeTimeZones();
  }

  static const AndroidNotificationDetails androidDetails =
      AndroidNotificationDetails(
    'channel_id',
    'channel_name',
    sound: RawResourceAndroidNotificationSound('noti_sound'),
    playSound: true,
    importance: Importance.max,
    priority: Priority.high,
    icon: '@drawable/lanuch_icon',
  );

  static const NotificationDetails details =
      NotificationDetails(android: androidDetails);

  /// Show Immediate Notification
  static Future<void> showNotification(Medicine medicine) async {
    await _notificationsPlugin.show(
        medicine.id, "Dose Time", "Its time For ${medicine.name} ", details);
  }

  static Future<void> dangerAlert(int heartRate) async {
    await _notificationsPlugin.show(
      1,
      "⚠️ High Heart Rate Alert!",
      "Your heart rate is at $heartRate BPM! Please take action immediately.",
      details,
    );
  }

  /// Schedule a One-Time Notification
  static Future<void> scheduleNotification(Medicine medicine) async {
    tz.TZDateTime tzScheduledTime = tz.TZDateTime.from(medicine.time, tz.local);
    await _notificationsPlugin.zonedSchedule(
      medicine.id,
      "Dose Time",
      "It's time for ${medicine.name}",
      tzScheduledTime,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  /// Schedule a Daily Repeating Notification
  static Future<void> scheduleDailyNotification(Medicine medicine) async {
    final now = DateTime.now();
    final todayTime = DateTime(
      now.year,
      now.month,
      now.day,
      medicine.time.hour,
      medicine.time.minute,
    );
    final scheduledTime = todayTime.isBefore(now)
        ? todayTime.add(const Duration(days: 1))
        : todayTime;

    await _notificationsPlugin.zonedSchedule(
      medicine.id,
      "Daily Reminder",
      "It's time for ${medicine.name}",
      tz.TZDateTime.from(scheduledTime, tz.local),
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  /// Cancel a specific scheduled notification
  static Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id);
  }

  /// Cancel all scheduled notifications
  static Future<void> cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
  }
}
