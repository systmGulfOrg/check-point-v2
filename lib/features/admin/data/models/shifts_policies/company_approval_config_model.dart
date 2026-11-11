import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_approval_config_model.freezed.dart';
part 'company_approval_config_model.g.dart';

@freezed
class CompanyApprovalConfigModel with _$CompanyApprovalConfigModel {
  const factory CompanyApprovalConfigModel({
    @Default('manager_then_hr') String leaveWorkflow,
    @Default(0) int holdingGracePeriodMinutes,
    @Default(true) bool adminsObserverOnly,
    @Default(false) bool adminCanOverrideHolding,
    @Default(false) bool enforceLateArrivalNoticeDeadline,
    @Default(60) int lateArrivalNoticeMinutes,
    @Default(false) bool enforceGracePeriodForLateArrival,
    @Default(false) bool enforceEarlyDepartureDeadline,
    @Default(50) int earlyDepartureDeadlinePercent,
    @Default(true) bool allowPermitsOnWeekends,
    @Default(true) bool allowPermitsOnHolidays,
    @Default(false) bool forceSameDayCasualLeave,
  }) = _CompanyApprovalConfigModel;

  factory CompanyApprovalConfigModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyApprovalConfigModelFromJson(json);
}
