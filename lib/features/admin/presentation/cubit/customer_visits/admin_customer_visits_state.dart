import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_visit_model.dart';

part 'admin_customer_visits_state.freezed.dart';

@freezed
abstract class AdminCustomerVisitsState with _$AdminCustomerVisitsState {
  const factory AdminCustomerVisitsState.initial() = _Initial;
  const factory AdminCustomerVisitsState.loading() = _Loading;
  const factory AdminCustomerVisitsState.success(
    List<CustomerVisitModel> visits,
  ) = _Success;
  const factory AdminCustomerVisitsState.actionSuccess(String message) =
      _ActionSuccess;
  const factory AdminCustomerVisitsState.error(String messageKey) = _Error;
}
