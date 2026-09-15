import 'package:freezed_annotation/freezed_annotation.dart';

part 'short_leave_request_body.freezed.dart';
part 'short_leave_request_body.g.dart';

@freezed
class ShortLeaveRequestBody with _$ShortLeaveRequestBody {
  const factory ShortLeaveRequestBody({
    required DateTime date,
    required String startTime,
    required String endTime,
    String? reason,
  }) = _ShortLeaveRequestBody;

  factory ShortLeaveRequestBody.fromJson(Map<String, dynamic> json) =>
      _$ShortLeaveRequestBodyFromJson(json);
}
