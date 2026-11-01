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
    // Backend schema is .strict() and names this accuracyM.
    if (accuracy != null) 'accuracyM': accuracy,
    'mockLocationDetected': mockLocationDetected,
    if (area != null) 'area': area,
    if (customerId != null) 'customerId': customerId,
  };
}

class OfflineSyncResultItem {
  final String clientUuid;

  /// One of `synced | pending | duplicate | conflict | rejected`, exactly as
  /// returned by `POST /api/v2/attendance/offline-sync`.
  final String status;
  final String? attendanceId;
  final List<String> reasons;

  const OfflineSyncResultItem({
    required this.clientUuid,
    required this.status,
    this.attendanceId,
    this.reasons = const [],
  });

  factory OfflineSyncResultItem.fromJson(Map<String, dynamic> json) {
    final reasons = <String>[
      ...?(json['reasons'] as List<dynamic>?)?.map((e) => e.toString()),
      if (json['reason'] != null) json['reason'].toString(),
    ];
    return OfflineSyncResultItem(
      clientUuid: json['clientUuid']?.toString() ?? '',
      status: json['status']?.toString().toLowerCase() ?? 'rejected',
      // Attendance ids are ULID strings, never numbers.
      attendanceId: json['attendanceId']?.toString(),
      reasons: reasons,
    );
  }
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
    final results =
        (value['results'] as List<dynamic>?)
            ?.map(
              (e) => OfflineSyncResultItem.fromJson(e as Map<String, dynamic>),
            )
            .toList() ??
        const <OfflineSyncResultItem>[];
    // The server returns only per-record results, so the totals are derived.
    int count(Set<String> statuses) =>
        results.where((r) => statuses.contains(r.status)).length;
    return OfflineSyncResponse(
      total: results.length,
      verified: count({'synced', 'duplicate'}),
      pending: count({'pending'}),
      failed: count({'conflict', 'rejected'}),
      results: results,
    );
  }
}

class PendingAttendanceItem {
  final String id;
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
      id: json['id']?.toString() ?? '',
      employeeId:
          json['employeeId']?.toString() ?? emp?['id']?.toString() ?? '',
      employeeName:
          emp?['name']?.toString() ??
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
      verificationReasons:
          (json['verificationReasons'] as List<dynamic>?)
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
