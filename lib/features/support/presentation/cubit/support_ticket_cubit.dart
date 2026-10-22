import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/support/data/apis/support_ticket_api_service.dart';

part 'support_ticket_cubit.freezed.dart';

// ── State ──────────────────────────────────────────────────────────────────

@freezed
sealed class SupportTicketState with _$SupportTicketState {
  const factory SupportTicketState.idle() = SupportTicketIdle;
  const factory SupportTicketState.loading() = SupportTicketLoading;
  const factory SupportTicketState.success() = SupportTicketSuccess;
  const factory SupportTicketState.failure(String message) =
      SupportTicketFailure;
}

// ── Cubit ──────────────────────────────────────────────────────────────────

class SupportTicketCubit extends SafeCubit<SupportTicketState> {
  SupportTicketCubit({required this.api})
    : super(const SupportTicketState.idle());

  final SupportTicketApiService api;

  /// Submits a ticket. [type] is 'feedback' or 'bug'.
  Future<void> submit({
    required String description,
    required String type,
  }) async {
    emit(const SupportTicketState.loading());
    try {
      final title = type == 'bug' ? 'Bug Report' : 'Feedback';
      await api.submit(title: title, description: description, type: type);
      safeEmit(const SupportTicketState.success());
    } catch (e) {
      safeEmit(const SupportTicketState.failure('support.errorMessage'));
    }
  }

  void reset() => emit(const SupportTicketState.idle());
}
