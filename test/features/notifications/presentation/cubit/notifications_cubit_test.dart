import 'package:check_point_v2/core/network/api_failure.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/notifications/data/models/notification_model.dart';
import 'package:check_point_v2/features/notifications/data/models/notification_page_model.dart';
import 'package:check_point_v2/features/notifications/domain/repos/notifications_repo.dart';
import 'package:check_point_v2/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:check_point_v2/features/notifications/presentation/cubit/notifications_state.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeRepo implements NotificationsRepo {
  int markReadCalls = 0;
  int markAllReadCalls = 0;
  bool markReadFails = false;

  final sampleItems = [
    NotificationModel(
      id: '1',
      title: 'Leave Approved',
      body: 'Your leave was approved',
      createdAt: DateTime.parse('2026-10-15T10:00:00Z'),
    ),
    NotificationModel(
      id: '2',
      title: 'Permit Approved',
      body: 'Your permit was approved',
      createdAt: DateTime.parse('2026-10-15T11:00:00Z'),
    ),
  ];

  @override
  Future<ApiResult<NotificationPageModel>> getNotifications() async {
    return ApiResult.success(
      NotificationPageModel(items: sampleItems, unreadCount: 2),
    );
  }

  @override
  Future<ApiResult<void>> markRead(String id) async {
    markReadCalls++;
    if (markReadFails) {
      return const ApiResult.failure(ApiFailure(messageKey: 'errors.network'));
    }
    return const ApiResult.success(null);
  }

  @override
  Future<ApiResult<void>> markAllRead() async {
    markAllReadCalls++;
    return const ApiResult.success(null);
  }

  @override
  Future<ApiResult<void>> registerPushToken({
    required String token,
    String? platform,
  }) async => const ApiResult.success(null);

  @override
  Future<ApiResult<void>> deregisterPushToken(String token) async =>
      const ApiResult.success(null);
}

void main() {
  group('NotificationsCubit', () {
    late _FakeRepo repo;
    late NotificationsCubit cubit;

    setUp(() {
      repo = _FakeRepo();
      cubit = NotificationsCubit(notificationsRepo: repo);
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is NotificationsInitial', () {
      expect(cubit.state, const NotificationsState.initial());
    });

    test('load emits loading then success', () async {
      await cubit.load();
      expect(
        cubit.state,
        isA<NotificationsSuccess>()
            .having((s) => s.notifications.length, 'length', 2)
            .having((s) => s.unreadCount, 'unreadCount', 2),
      );
    });

    test('markRead updates state locally without refetching', () async {
      await cubit.load();
      await cubit.markRead('1');

      expect(repo.markReadCalls, 1);
      final state = cubit.state as NotificationsSuccess;
      expect(state.unreadCount, 1);
      final item1 = state.notifications.firstWhere((n) => n.id == '1');
      expect(item1.readAt, isNotNull);
      final item2 = state.notifications.firstWhere((n) => n.id == '2');
      expect(item2.readAt, isNull);
    });

    test('markAllRead marks all items read locally', () async {
      await cubit.load();
      await cubit.markAllRead();

      expect(repo.markAllReadCalls, 1);
      final state = cubit.state as NotificationsSuccess;
      expect(state.unreadCount, 0);
      expect(state.notifications.every((n) => n.readAt != null), isTrue);
    });
  });
}
