import 'package:check_point_v2/core/bloc/safe_cubit.dart';
import 'package:check_point_v2/features/admin/data/repos/subscription_repo.dart';
import 'admin_subscription_state.dart';

class AdminSubscriptionCubit extends SafeCubit<AdminSubscriptionState> {
  AdminSubscriptionCubit({required this.subscriptionRepo})
    : super(const AdminSubscriptionState.initial());

  final SubscriptionRepo subscriptionRepo;

  Future<void> load() async {
    emit(const AdminSubscriptionState.loading());
    final result = await subscriptionRepo.getSubscriptionSummary();
    result.when(
      success: (summary) => safeEmit(AdminSubscriptionState.success(summary)),
      failure: (failure) =>
          safeEmit(AdminSubscriptionState.error(failure.messageKey)),
    );
  }

  Future<void> requestMoreSeats({
    required int requestedLimit,
    String? reason,
  }) async {
    final result = await subscriptionRepo.createSeatRequest(
      requestedLimit: requestedLimit,
      reason: reason,
    );
    final sent = result.when(
      success: (_) => true,
      failure: (failure) {
        safeEmit(AdminSubscriptionState.requestFailed(failure.messageKey));
        return false;
      },
    );
    if (sent) {
      safeEmit(const AdminSubscriptionState.requestSent());
      await load();
    }
  }

  Future<void> cancelPendingRequest(String id) async {
    final result = await subscriptionRepo.cancelSeatRequest(id);
    result.when(
      success: (_) => load(),
      failure: (failure) =>
          safeEmit(AdminSubscriptionState.requestFailed(failure.messageKey)),
    );
  }
}
