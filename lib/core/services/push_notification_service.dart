import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import 'package:check_point_v2/core/utils/app_logger.dart';
import 'package:check_point_v2/firebase_options.dart';
import 'local_notification_service.dart';

@pragma('vm:entry-point')
Future<void> onBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

abstract class PushTokenSource {
  Future<String?> token();
  Stream<String> get tokenRefresh;
  Future<void> deleteToken();
}

class PushNotificationService implements PushTokenSource {
  PushNotificationService({
    required this.messaging,
    required this.localNotificationService,
  });

  final FirebaseMessaging messaging;
  final LocalNotificationService localNotificationService;

  final ValueNotifier<Map<String, dynamic>?> tappedMessageData =
      ValueNotifier<Map<String, dynamic>?>(null);

  Future<void> initialize() async {
    final settings = await messaging.requestPermission();
    AppLogger.debug('Push permission: ${settings.authorizationStatus.name}');

    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen(_showForeground);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleTap);

    final initial = await messaging.getInitialMessage();
    if (initial != null) _handleTap(initial);
  }

  @override
  Future<String?> token() async {
    try {
      if (Platform.isIOS) await _waitForApnsToken();
      return await messaging.getToken();
    } catch (e) {
      AppLogger.error('Could not read FCM token: $e');
      return null;
    }
  }

  Future<void> _waitForApnsToken() async {
    for (var attempt = 0; attempt < 12; attempt++) {
      if (await messaging.getAPNSToken() != null) return;
      await Future<void>.delayed(const Duration(milliseconds: 2500));
    }
  }

  @override
  Stream<String> get tokenRefresh => messaging.onTokenRefresh;

  @override
  Future<void> deleteToken() => messaging.deleteToken();

  Future<void> _showForeground(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;
    await localNotificationService.showPush(
      id: message.messageId?.hashCode ?? DateTime.now().millisecondsSinceEpoch,
      title: notification.title ?? '',
      body: notification.body ?? '',
    );
  }

  void _handleTap(RemoteMessage message) {
    tappedMessageData.value = message.data;
  }
}
