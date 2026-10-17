import 'dart:async';

import 'package:check_point_v2/core/network/api_failure.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/core/services/push_notification_service.dart';
import 'package:check_point_v2/core/services/push_token_registrar.dart';
import 'package:check_point_v2/features/notifications/data/models/notification_page_model.dart';
import 'package:check_point_v2/features/notifications/domain/repos/notifications_repo.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeNotificationsRepo implements NotificationsRepo {
  _FakeNotificationsRepo({this.registerFails = false});

  final bool registerFails;
  final registeredTokens = <String>[];
  final deregisteredTokens = <String>[];

  @override
  Future<ApiResult<NotificationPageModel>> getNotifications() async =>
      const ApiResult.success(NotificationPageModel(items: [], unreadCount: 0));

  @override
  Future<ApiResult<void>> markRead(String id) async =>
      const ApiResult.success(null);

  @override
  Future<ApiResult<void>> markAllRead() async => const ApiResult.success(null);

  @override
  Future<ApiResult<void>> registerPushToken({
    required String token,
    String? platform,
  }) async {
    if (registerFails) {
      return const ApiResult.failure(ApiFailure(messageKey: 'errors.network'));
    }
    registeredTokens.add(token);
    return const ApiResult.success(null);
  }

  @override
  Future<ApiResult<void>> deregisterPushToken(String token) async {
    deregisteredTokens.add(token);
    return const ApiResult.success(null);
  }
}

class _FakeTokenSource implements PushTokenSource {
  _FakeTokenSource(this._token);

  final String? _token;
  final deleteCalls = <void>[];
  final _controller = StreamController<String>.broadcast();

  @override
  Future<String?> token() async => _token;

  @override
  Stream<String> get tokenRefresh => _controller.stream;

  @override
  Future<void> deleteToken() async => deleteCalls.add(null);
}

void main() {
  group('PushTokenRegistrar', () {
    test('start() registers the current token once', () async {
      final repo = _FakeNotificationsRepo();
      final registrar = PushTokenRegistrar(
        pushNotificationService: _FakeTokenSource('tok-1'),
        notificationsRepo: repo,
      );

      await registrar.start();

      expect(repo.registeredTokens, ['tok-1']);
    });

    test('a register failure is swallowed, not thrown', () async {
      final repo = _FakeNotificationsRepo(registerFails: true);
      final registrar = PushTokenRegistrar(
        pushNotificationService: _FakeTokenSource('tok-2'),
        notificationsRepo: repo,
      );

      await expectLater(registrar.start(), completes);
      expect(repo.registeredTokens, isEmpty);
    });

    test('stop() deregisters the last registered token exactly once', () async {
      final repo = _FakeNotificationsRepo();
      final source = _FakeTokenSource('tok-3');
      final registrar = PushTokenRegistrar(
        pushNotificationService: source,
        notificationsRepo: repo,
      );

      await registrar.start();
      await registrar.stop();

      expect(repo.deregisteredTokens, ['tok-3']);
      expect(source.deleteCalls, hasLength(1));
    });

    test('stop() without a prior start() is a no-op, not an error', () async {
      final repo = _FakeNotificationsRepo();
      final registrar = PushTokenRegistrar(
        pushNotificationService: _FakeTokenSource(null),
        notificationsRepo: repo,
      );

      await expectLater(registrar.stop(), completes);
      expect(repo.deregisteredTokens, isEmpty);
    });

    test('a null token from the source is never registered', () async {
      final repo = _FakeNotificationsRepo();
      final registrar = PushTokenRegistrar(
        pushNotificationService: _FakeTokenSource(null),
        notificationsRepo: repo,
      );

      await registrar.start();

      expect(repo.registeredTokens, isEmpty);
    });
  });
}
