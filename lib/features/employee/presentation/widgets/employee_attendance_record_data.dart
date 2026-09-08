class EmployeeAttendanceRecordData {
  const EmployeeAttendanceRecordData({
    required this.date,
    required this.checkIn,
    this.checkOut,
    this.area,
    this.durationHours,
    required this.status,
    this.isLate = false,
    this.isEarly = false,
  });

  final String date;
  final String checkIn;
  final String? checkOut;
  final String? area;
  final String? durationHours;
  final String status;
  final bool isLate;
  final bool isEarly;
}
