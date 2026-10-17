import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  LocalNotificationService({FlutterLocalNotificationsPlugin? plugin})
    : plugin = plugin ?? FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin plugin;

  static const int attendanceReminderId = 1001;
  static const int tasksReminderId = 1002;

  /// Channel for FCM pushes shown while the app is in the foreground. Must stay
  /// in sync with `default_notification_channel_id` in AndroidManifest.xml so a
  /// push looks the same whether it arrives in the foreground or background.
  static const String pushChannelId = 'check_point_push';

  Future<void> initialize() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@drawable/ic_notification'),
      iOS: DarwinInitializationSettings(),
    );
    await plugin.initialize(settings);

    final android = plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await android?.requestNotificationsPermission();
    await android?.createNotificationChannel(
      const AndroidNotificationChannel(
        pushChannelId,
        'Check-Point notifications',
        description: 'Leave, permit and attendance notifications',
        importance: Importance.high,
      ),
    );
  }

  /// Shows a push that arrived while the app was in the foreground. Android
  /// suppresses the system notification in that case, so it is rendered here.
  Future<void> showPush({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) {
    return plugin.show(
      id,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          pushChannelId,
          'Check-Point notifications',
          channelDescription: 'Leave, permit and attendance notifications',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      payload: payload,
    );
  }

  Future<void> scheduleDaily({
    required int id,
    required String title,
    required String body,
    required DateTime time,
  }) async {
    final now = DateTime.now();
    var scheduled = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
    if (!scheduled.isAfter(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    await plugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduled, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'employee_reminders',
          'Employee reminders',
          channelDescription: 'Daily attendance and task reminders',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancel(int id) => plugin.cancel(id);
}
