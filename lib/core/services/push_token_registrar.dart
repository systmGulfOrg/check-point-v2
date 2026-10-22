import 'dart:async';
import 'dart:io' show Platform;

import 'package:check_point_v2/core/utils/app_logger.dart';
import 'package:check_point_v2/features/notifications/domain/repos/notifications_repo.dart';
import 'push_notification_service.dart';

abstract class PushTokenRegistrarContract {
  Future<void> start();
  Future<void> stop();
}

class PushTokenRegistrar implements PushTokenRegistrarContract {
  PushTokenRegistrar({
    required this.pushNotificationService,
    required this.notificationsRepo,
  });

  final PushTokenSource pushNotificationService;
  final NotificationsRepo notificationsRepo;

  StreamSubscription<String>? _refreshSubscription;
  String? _lastRegistered;

  @override
  Future<void> start() async {
    final token = await pushNotificationService.token();
    if (token != null) {
      await _register(token);
    } else {
      unawaited(_retryOnce());
    }

    await _refreshSubscription?.cancel();
    _refreshSubscription = pushNotificationService.tokenRefresh.listen(
      (newToken) => unawaited(_register(newToken)),
    );
  }

  Future<void> _retryOnce() async {
    await Future<void>.delayed(const Duration(seconds: 15));
    if (_lastRegistered != null) return;
    final token = await pushNotificationService.token();
    if (token != null) await _register(token);
  }

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
    if (token == _lastRegistered) return;

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
