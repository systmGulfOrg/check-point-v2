import 'package:check_point_v2/core/bloc/safe_cubit.dart';

import 'package:check_point_v2/features/admin/data/models/locations/customer_request_model.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_locations_repo.dart';
import 'admin_customers_state.dart';

class AdminCustomersCubit extends SafeCubit<AdminCustomersState> {
  AdminCustomersCubit({required this.locationsRepo})
    : super(const AdminCustomersState.initial());
  final AdminLocationsRepo locationsRepo;
  String currentType = 'Customer';

  Future<void> load({required String type}) async {
    currentType = type.toLowerCase() == 'site' ? 'Site' : 'Customer';
    emit(const AdminCustomersState.loading());
    final result = await locationsRepo.getCustomersByType(currentType);
    result.when(
      success: (data) => safeEmit(AdminCustomersState.success(data)),
      failure: (failure) =>
          safeEmit(AdminCustomersState.error(failure.messageKey)),
    );
  }

  Future<bool> add(CustomerRequestModel request) async {
    final result = await locationsRepo.addCustomer(request);
    return result.when(
      success: (_) async {
        await load(type: currentType);
        return true;
      },
      failure: (failure) {
        safeEmit(AdminCustomersState.error(failure.messageKey));
        return false;
      },
    );
  }

  Future<bool> edit(String id, CustomerRequestModel request) async {
    final result = await locationsRepo.editCustomer(id, request);
    return result.when(
      success: (_) async {
        await load(type: currentType);
        return true;
      },
      failure: (failure) {
        safeEmit(AdminCustomersState.error(failure.messageKey));
        return false;
      },
    );
  }

  Future<void> delete(String id) async {
    final result = await locationsRepo.deleteCustomer(id);
    await result.when(
      success: (_) async => await load(type: currentType),
      failure: (failure) async =>
          safeEmit(AdminCustomersState.error(failure.messageKey)),
    );
  }
}
