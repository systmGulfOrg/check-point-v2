import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import 'package:check_point_v2/core/utils/app_logger.dart';
import 'package:check_point_v2/firebase_options.dart';
import 'local_notification_service.dart';

/// Handles a push that arrives while the app is terminated or backgrounded.
///
/// Must be a top-level function: Firebase runs it in a separate isolate, which
/// has none of the app's state, so nothing from the running app is available
/// here. The OS draws the notification itself, so there is nothing to show.
@pragma('vm:entry-point')
Future<void> onBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

/// The token-registration surface of [PushNotificationService] — kept
/// narrow and separate so a consumer that only reads/rotates/deletes the
/// token (PushTokenRegistrar) does not depend on FirebaseMessaging directly,
/// and can be faked in a plain unit test without Firebase.initializeApp().
abstract class PushTokenSource {
  Future<String?> token();
  Stream<String> get tokenRefresh;
  Future<void> deleteToken();
}

/// Owns the FCM lifecycle: permission, token, and incoming messages.
///
/// A push arriving in the foreground is not drawn by the OS, so it is rendered
/// through [LocalNotificationService]; background and terminated pushes are
/// drawn by the system and only need the tap handler.
class PushNotificationService implements PushTokenSource {
  PushNotificationService({
    required this.messaging,
    required this.localNotificationService,
  });

  final FirebaseMessaging messaging;
  final LocalNotificationService localNotificationService;

  /// Set when the user taps a push, so the app can route once the UI is ready.
  final ValueNotifier<Map<String, dynamic>?> tappedMessageData =
      ValueNotifier<Map<String, dynamic>?>(null);

  Future<void> initialize() async {
    final settings = await messaging.requestPermission();
    AppLogger.debug('Push permission: ${settings.authorizationStatus.name}');

    // iOS suppresses pushes until the APNs token is resolved; on Android this
    // is a no-op.
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen(_showForeground);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleTap);

    // A push that launched the app from terminated state is not delivered to
    // onMessageOpenedApp, so it has to be read once at startup.
    final initial = await messaging.getInitialMessage();
    if (initial != null) _handleTap(initial);
  }

  /// The FCM registration token identifying this device/install.
  @override
  Future<String?> token() async {
    try {
      return await messaging.getToken();
    } catch (e) {
      // On iOS this throws until APNs is configured; it must not break startup.
      AppLogger.error('Could not read FCM token: $e');
      return null;
    }
  }

  /// Emits a new token whenever FCM rotates it.
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
