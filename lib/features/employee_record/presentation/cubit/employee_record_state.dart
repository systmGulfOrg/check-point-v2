import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:check_point_v2/features/employee_record/data/models/employee_record_model.dart';

part 'employee_record_state.freezed.dart';

@freezed
class EmployeeRecordState with _$EmployeeRecordState {
  const factory EmployeeRecordState.initial() = EmployeeRecordInitial;
  const factory EmployeeRecordState.loading(DateTime month) = EmployeeRecordLoading;
  const factory EmployeeRecordState.success(EmployeeRecordModel record, DateTime month) =
      EmployeeRecordSuccess;
  const factory EmployeeRecordState.error(String messageKey, DateTime month) =
      EmployeeRecordError;
}
