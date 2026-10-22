import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:check_point_v2/features/admin/data/models/subscription/subscription_summary_model.dart';

part 'admin_subscription_state.freezed.dart';

@freezed
abstract class AdminSubscriptionState with _$AdminSubscriptionState {
  const factory AdminSubscriptionState.initial() = AdminSubscriptionInitial;
  const factory AdminSubscriptionState.loading() = AdminSubscriptionLoading;
  const factory AdminSubscriptionState.success(
    SubscriptionSummaryModel summary,
  ) = AdminSubscriptionSuccess;
  const factory AdminSubscriptionState.error(String messageKey) =
      AdminSubscriptionError;

  const factory AdminSubscriptionState.requestSent() =
      AdminSubscriptionRequestSent;
  const factory AdminSubscriptionState.requestFailed(String messageKey) =
      AdminSubscriptionRequestFailed;
}
