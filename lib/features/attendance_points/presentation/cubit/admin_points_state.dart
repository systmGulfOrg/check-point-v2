import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/admin_points_employee_model.dart';

part 'admin_points_state.freezed.dart';

@freezed
class AdminPointsState with _$AdminPointsState {
  const factory AdminPointsState.initial() = AdminPointsInitial;
  const factory AdminPointsState.loading() = AdminPointsLoading;
  const factory AdminPointsState.loaded(AdminPointsEmployeesPageModel page) =
      AdminPointsLoaded;
  const factory AdminPointsState.error(String messageKey) = AdminPointsError;
}
