import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../data/models/customer_request_model.dart';
import '../../data/repos/admin_locations_repo.dart';
import 'admin_customers_state.dart';

class AdminCustomersCubit extends Cubit<AdminCustomersState> {
  AdminCustomersCubit({required this.locationsRepo})
    : super(const AdminCustomersState.initial());
  final AdminLocationsRepo locationsRepo;
  String currentType = 'Customer';

  Future<void> load({required String type}) async {
    currentType = type;
    emit(const AdminCustomersState.loading());
    final result = await locationsRepo.getCustomersByType(type);
    switch (result) {
      case Success(:final data):
        emit(AdminCustomersState.success(data));
      case Failure(:final failure):
        emit(AdminCustomersState.error(failure.messageKey));
    }
  }

  Future<void> add(CustomerRequestModel request) async {
    final result = await locationsRepo.addCustomer(request);
    switch (result) {
      case Success():
        await load(type: currentType);
      case Failure(:final failure):
        emit(AdminCustomersState.error(failure.messageKey));
    }
  }

  Future<void> edit(String id, CustomerRequestModel request) async {
    final result = await locationsRepo.editCustomer(id, request);
    switch (result) {
      case Success():
        await load(type: currentType);
      case Failure(:final failure):
        emit(AdminCustomersState.error(failure.messageKey));
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
