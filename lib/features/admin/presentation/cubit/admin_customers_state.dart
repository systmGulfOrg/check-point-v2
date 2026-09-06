import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/customer_response_model.dart';
part 'admin_customers_state.freezed.dart';

@freezed
abstract class AdminCustomersState with _$AdminCustomersState {
  const factory AdminCustomersState.initial() = AdminCustomersInitial;
  const factory AdminCustomersState.loading() = AdminCustomersLoading;
  const factory AdminCustomersState.success(List<CustomerModel> customers) =
      AdminCustomersSuccess;
  const factory AdminCustomersState.error(String messageKey) =
      AdminCustomersError;
}
