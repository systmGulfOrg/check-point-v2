import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/notifications_repo_impl.dart';
import 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit({required this.notificationsRepo})
    : super(const NotificationsState.initial());

  final NotificationsRepoImpl notificationsRepo;

  Future<void> load() async {
    emit(const NotificationsState.loading());
    final result = await notificationsRepo.getNotifications();
    result.when(
      success: (page) =>
          emit(NotificationsState.success(page.items, page.unreadCount)),
      failure: (failure) => emit(NotificationsState.error(failure.messageKey)),
    );
  }

  Future<void> markRead(String id) async {
    final result = await notificationsRepo.markRead(id);
    result.when(success: (_) => load(), failure: (_) {});
  }

  Future<void> markAllRead() async {
    final result = await notificationsRepo.markAllRead();
    result.when(success: (_) => load(), failure: (_) {});
  }
}
