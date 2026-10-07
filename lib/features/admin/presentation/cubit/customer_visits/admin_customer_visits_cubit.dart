import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_visit_model.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_customer_visits_repo.dart';
import 'admin_customer_visits_state.dart';

class AdminCustomerVisitsCubit extends Cubit<AdminCustomerVisitsState> {
  AdminCustomerVisitsCubit({required this.visitsRepo})
    : super(const AdminCustomerVisitsState.initial());

  final AdminCustomerVisitsRepo visitsRepo;

  Future<void> loadCustomerVisits(String customerId) async {
    emit(const AdminCustomerVisitsState.loading());
    final result = await visitsRepo.getCustomerVisits(customerId);
    switch (result) {
      case Success(:final data):
        emit(AdminCustomerVisitsState.success(data));
      case Failure(:final failure):
        emit(AdminCustomerVisitsState.error(failure.messageKey));
    }
  }

  Future<void> loadAllVisits() async {
    emit(const AdminCustomerVisitsState.loading());
    final result = await visitsRepo.getAllVisits();
    switch (result) {
      case Success(:final data):
        emit(AdminCustomerVisitsState.success(data));
      case Failure(:final failure):
        emit(AdminCustomerVisitsState.error(failure.messageKey));
    }
  }

  String? lastErrorKey;

  Future<bool> addVisitPlan(CustomerVisitModel visit) async {
    final previous = state;
    emit(const AdminCustomerVisitsState.loading());
    final result = await visitsRepo.addVisitPlan(visit);
    switch (result) {
      case Success():
        if (visit.customerId != null && visit.customerId!.isNotEmpty) {
          await loadCustomerVisits(visit.customerId!);
        } else {
          await loadAllVisits();
        }
        return true;
      case Failure(:final failure):
        lastErrorKey = failure.messageKey;
        emit(previous);
        return false;
      default:
        emit(previous);
        return false;
    }
  }

  Future<bool> updateVisitOutcome({
    required String visitId,
    required String customerId,
    required String outcome,
    required String status,
    String? notes,
    String? documentName,
    String? documentUrl,
  }) async {
    emit(const AdminCustomerVisitsState.loading());
    final result = await visitsRepo.updateVisitOutcome(
      visitId: visitId,
      outcome: outcome,
      status: status,
      notes: notes,
      documentName: documentName,
      documentUrl: documentUrl,
    );
    switch (result) {
      case Success():
        if (customerId.isNotEmpty) {
          await loadCustomerVisits(customerId);
        } else {
          await loadAllVisits();
        }
        return true;
      case Failure(:final failure):
        emit(AdminCustomerVisitsState.error(failure.messageKey));
        return false;
      default:
        return false;
    }
  }
}
