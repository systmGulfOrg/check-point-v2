import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_request_model.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_locations_repo.dart';
import 'admin_customers_state.dart';

class AdminCustomersCubit extends Cubit<AdminCustomersState> {
  AdminCustomersCubit({required this.locationsRepo})
    : super(const AdminCustomersState.initial());
  final AdminLocationsRepo locationsRepo;
  String currentType = 'Customer';

  Future<void> load({required String type}) async {
    currentType = type.toLowerCase() == 'site' ? 'Site' : 'Customer';
    emit(const AdminCustomersState.loading());
    final result = await locationsRepo.getCustomersByType(currentType);
    switch (result) {
      case Success(:final data):
        emit(AdminCustomersState.success(data));
      case Failure(:final failure):
        emit(AdminCustomersState.error(failure.messageKey));
    }
  }

  Future<bool> add(CustomerRequestModel request) async {
    final result = await locationsRepo.addCustomer(request);
    switch (result) {
      case Success():
        await load(type: currentType);
        return true;
      case Failure(:final failure):
        emit(AdminCustomersState.error(failure.messageKey));
        return false;
      default:
        return false;
    }
  }

  Future<bool> edit(String id, CustomerRequestModel request) async {
    final result = await locationsRepo.editCustomer(id, request);
    switch (result) {
      case Success():
        await load(type: currentType);
        return true;
      case Failure(:final failure):
        emit(AdminCustomersState.error(failure.messageKey));
        return false;
      default:
        return false;
    }
  }

  Future<void> delete(String id) async {
    final result = await locationsRepo.deleteCustomer(id);
    switch (result) {
      case Success():
        await load(type: currentType);
      case Failure(:final failure):
        emit(AdminCustomersState.error(failure.messageKey));
    }
  }
}
