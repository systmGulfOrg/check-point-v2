import 'package:check_point_v2/core/bloc/safe_cubit.dart';
import 'package:check_point_v2/core/utils/app_logger.dart';
import '../../domain/repos/notifications_repo.dart';
import 'notifications_state.dart';

class NotificationsCubit extends SafeCubit<NotificationsState> {
  NotificationsCubit({required this.notificationsRepo})
    : super(const NotificationsState.initial());

  final NotificationsRepo notificationsRepo;

  Future<void> load() async {
    emit(const NotificationsState.loading());
    final result = await notificationsRepo.getNotifications();
    result.when(
      success: (page) =>
          safeEmit(NotificationsState.success(page.items, page.unreadCount)),
      failure: (failure) =>
          safeEmit(NotificationsState.error(failure.messageKey)),
    );
  }

  Future<void> markRead(String id) async {
    final result = await notificationsRepo.markRead(id);
    result.when(
      success: (_) {
        final current = state;
        if (current is NotificationsSuccess) {
          final updated = current.notifications.map((n) {
            if (n.id == id && n.readAt == null) {
              return n.copyWith(readAt: DateTime.now());
            }
            return n;
          }).toList();
          final newUnread = (current.unreadCount - 1).clamp(
            0,
            current.notifications.length,
          );
          safeEmit(NotificationsState.success(updated, newUnread));
        }
      },
      failure: (failure) {
        AppLogger.error(
          'Failed to mark notification as read: ${failure.messageKey}',
        );
      },
    );
  }

  Future<void> markAllRead() async {
    final result = await notificationsRepo.markAllRead();
    result.when(
      success: (_) {
        final current = state;
        if (current is NotificationsSuccess) {
          final now = DateTime.now();
          final updated = current.notifications.map((n) {
            if (n.readAt == null) {
              return n.copyWith(readAt: now);
            }
            return n;
          }).toList();
          safeEmit(NotificationsState.success(updated, 0));
        }
      },
      failure: (failure) {
        AppLogger.error(
          'Failed to mark all notifications as read: ${failure.messageKey}',
        );
      },
    );
  }
}
