class EmployeeTaskLogModel {
  const EmployeeTaskLogModel({
    required this.workDate,
    required this.durationMinutes,
    this.note,
  });

  final String workDate;
  final int durationMinutes;
  final String? note;

  factory EmployeeTaskLogModel.fromJson(Map<String, dynamic> json) {
    final duration = json['durationMinutes'] ?? json['duration_minutes'] ?? 0;
    return EmployeeTaskLogModel(
      workDate: '${json['workDate'] ?? json['work_date'] ?? ''}',
      durationMinutes: duration is num ? duration.toInt() : 0,
      note: json['note'] as String?,
    );
  }
}
