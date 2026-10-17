import 'dart:async';
import 'dart:io' show Platform;

import 'package:check_point_v2/core/utils/app_logger.dart';
import 'package:check_point_v2/features/notifications/domain/repos/notifications_repo.dart';
import 'push_notification_service.dart';

/// What `LoginUseCase`/`AuthSessionCubit` need from push-token registration —
/// kept narrow and separate from [PushTokenRegistrar]'s own dependencies so a
/// test exercising login/logout does not need a real Firebase instance just
/// to satisfy a constructor.
abstract class PushTokenRegistrarContract {
  Future<void> start();
  Future<void> stop();
}

/// Keeps the backend's record of this device's FCM token in sync with
/// [PushNotificationService].
///
/// Registration must never block or fail a login — a push-registration
/// failure is logged and swallowed, not surfaced as an auth error.
class PushTokenRegistrar implements PushTokenRegistrarContract {
  PushTokenRegistrar({
    required this.pushNotificationService,
    required this.notificationsRepo,
  });

  final PushTokenSource pushNotificationService;
  final NotificationsRepo notificationsRepo;

  StreamSubscription<String>? _refreshSubscription;
  String? _lastRegistered;

  /// Registers the current token (if any) and starts following refreshes.
  /// Call once after a successful login.
  @override
  Future<void> start() async {
    final token = await pushNotificationService.token();
    if (token != null) {
      await _register(token);
    } else {
      // The APNs handshake can still be in flight past our own wait (e.g. a
      // slow network on first install). onTokenRefresh covers a later token
      // rotation, but not this case — nothing emits if FCM never produced a
      // token to begin with. One delayed retry catches that gap without
      // polling indefinitely.
      unawaited(_retryOnce());
    }

    await _refreshSubscription?.cancel();
    _refreshSubscription = pushNotificationService.tokenRefresh.listen(
      (newToken) => unawaited(_register(newToken)),
    );
  }

  Future<void> _retryOnce() async {
    await Future<void>.delayed(const Duration(seconds: 15));
    if (_lastRegistered != null) return; // tokenRefresh already handled it
    final token = await pushNotificationService.token();
    if (token != null) await _register(token);
  }

  /// Stops following refreshes and deregisters the current token. Call on
  /// logout — otherwise a signed-out device keeps receiving the next
  /// signed-in user's pushes (e.g. on a shared phone).
  @override
  Future<void> stop() async {
    await _refreshSubscription?.cancel();
    _refreshSubscription = null;

    final token = _lastRegistered;
    _lastRegistered = null;
    if (token == null) return;

    final result = await notificationsRepo.deregisterPushToken(token);
    result.when(
      success: (_) {},
      failure: (f) =>
          AppLogger.error('Push token deregister failed: ${f.messageKey}'),
    );
    await pushNotificationService.deleteToken();
  }

  Future<void> _register(String token) async {
    if (token == _lastRegistered) return; // already registered, skip the call

    final result = await notificationsRepo.registerPushToken(
      token: token,
      platform: Platform.isIOS
          ? 'ios'
          : Platform.isAndroid
          ? 'android'
          : null,
    );
    result.when(
      success: (_) => _lastRegistered = token,
      failure: (f) =>
          AppLogger.error('Push token register failed: ${f.messageKey}'),
    );
  }
}
