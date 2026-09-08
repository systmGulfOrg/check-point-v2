import 'package:json_annotation/json_annotation.dart';

part 'track_user_request_body.g.dart';

@JsonSerializable()
class TrackUserRequestBody {
  const TrackUserRequestBody({
    required this.employeeId,
    required this.latitude,
    required this.longitude,
    this.recordedAt,
  });

  final String employeeId;
  final double latitude;
  final double longitude;
  final String? recordedAt;

  factory TrackUserRequestBody.fromJson(Map<String, dynamic> json) =>
      _$TrackUserRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$TrackUserRequestBodyToJson(this);
}
