class OfflineSyncAnchor {
  final DateTime serverTime;
  final int monotonicMs;
  final String bootId;

  const OfflineSyncAnchor({
    required this.serverTime,
    required this.monotonicMs,
    required this.bootId,
  });

  Map<String, dynamic> toJson() => {
        'serverTime': serverTime.toIso8601String(),
        'monotonicMs': monotonicMs,
        'bootId': bootId,
      };

  factory OfflineSyncAnchor.fromJson(Map<String, dynamic> json) =>
      OfflineSyncAnchor(
        serverTime: DateTime.parse(json['serverTime'] as String),
        monotonicMs: (json['monotonicMs'] as num).toInt(),
        bootId: json['bootId'] as String,
      );
}

class OfflineSyncRecord {
  final String clientUuid;
  final String type; // 'in' | 'out'
  final DateTime wallClock;
  final int monotonicMs;
  final String bootId;
  final OfflineSyncAnchor? anchor;
  final double? latitude;
  final double? longitude;
  final double? accuracy;
  final bool mockLocationDetected;
  final String? area;
  final String? customerId;

  const OfflineSyncRecord({
    required this.clientUuid,
    required this.type,
    required this.wallClock,
    required this.monotonicMs,
    required this.bootId,
    this.anchor,
    this.latitude,
    this.longitude,
    this.accuracy,
    this.mockLocationDetected = false,
    this.area,
    this.customerId,
  });

  Map<String, dynamic> toJson() => {
        'clientUuid': clientUuid,
        'type': type,
        'wallClock': wallClock.toIso8601String(),
        'monotonicMs': monotonicMs,
        'bootId': bootId,
        if (anchor != null) 'anchor': anchor!.toJson(),
        if (latitude != null) 'latitude': latitude,
        if (longitude != null) 'longitude': longitude,
        if (accuracy != null) 'accuracy': accuracy,
        'mockLocationDetected': mockLocationDetected,
        if (area != null) 'area': area,
        if (customerId != null) 'customerId': customerId,
      };
}

class OfflineSyncResultItem {
  final String clientUuid;
  final String status;
  final int? attendanceId;
  final List<String> reasons;

  const OfflineSyncResultItem({
    required this.clientUuid,
    required this.status,
    this.attendanceId,
    this.reasons = const [],
  });

  factory OfflineSyncResultItem.fromJson(Map<String, dynamic> json) =>
      OfflineSyncResultItem(
        clientUuid: json['clientUuid'] as String? ?? '',
        status: json['status'] as String? ?? 'REJECTED',
        attendanceId: (json['attendanceId'] as num?)?.toInt(),
        reasons: (json['reasons'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            const [],
      );
}

class OfflineSyncResponse {
  final int total;
  final int verified;
  final int pending;
  final int failed;
  final List<OfflineSyncResultItem> results;

  const OfflineSyncResponse({
    required this.total,
    required this.verified,
    required this.pending,
    required this.failed,
    required this.results,
  });

  factory OfflineSyncResponse.fromJson(Map<String, dynamic> json) {
    final value = json['value'] as Map<String, dynamic>? ?? json;
    final resultsList = (value['results'] as List<dynamic>?)
            ?.map((e) => OfflineSyncResultItem.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
    return OfflineSyncResponse(
      total: (value['total'] as num?)?.toInt() ?? 0,
      verified: (value['verified'] as num?)?.toInt() ?? 0,
      pending: (value['pending'] as num?)?.toInt() ?? 0,
      failed: (value['failed'] as num?)?.toInt() ?? 0,
      results: resultsList,
    );
  }
}

class PendingAttendanceItem {
  final int id;
  final String employeeId;
  final String employeeName;
  final String? employeeCode;
  final String? employeeImageUrl;
  final DateTime? attendanceDate;
  final DateTime? clockInTime;
  final DateTime? clockOutTime;
  final String verificationStatus;
  final List<String> verificationReasons;
  final DateTime? capturedWallClock;
  final bool isInsideGeofence;

  const PendingAttendanceItem({
    required this.id,
    required this.employeeId,
    required this.employeeName,
    this.employeeCode,
    this.employeeImageUrl,
    this.attendanceDate,
    this.clockInTime,
    this.clockOutTime,
    required this.verificationStatus,
    this.verificationReasons = const [],
    this.capturedWallClock,
    this.isInsideGeofence = true,
  });

  factory PendingAttendanceItem.fromJson(Map<String, dynamic> json) {
    final emp = json['employee'] as Map<String, dynamic>?;
    return PendingAttendanceItem(
      id: (json['id'] as num).toInt(),
      employeeId: json['employeeId']?.toString() ?? '',
      employeeName: emp?['name']?.toString() ??
          json['employeeName']?.toString() ??
          'Employee',
      employeeCode: emp?['employeeCode']?.toString(),
      employeeImageUrl: emp?['imageUrl']?.toString(),
      attendanceDate: json['attendanceDate'] != null
          ? DateTime.tryParse(json['attendanceDate'].toString())
          : null,
      clockInTime: json['clockInTime'] != null
          ? DateTime.tryParse(json['clockInTime'].toString())
          : null,
      clockOutTime: json['clockOutTime'] != null
          ? DateTime.tryParse(json['clockOutTime'].toString())
          : null,
      verificationStatus:
          json['verificationStatus']?.toString() ?? 'PENDING_VERIFICATION',
      verificationReasons: (json['verificationReasons'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      capturedWallClock: json['capturedWallClock'] != null
          ? DateTime.tryParse(json['capturedWallClock'].toString())
          : null,
      isInsideGeofence: json['isInsideGeofence'] as bool? ?? true,
    );
  }
}
