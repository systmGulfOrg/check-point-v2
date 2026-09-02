class EmployeeAttendanceRecordData {
  const EmployeeAttendanceRecordData({
    required this.date,
    required this.checkIn,
    this.checkOut,
    this.durationHours,
    required this.status,
  });

  final String date;
  final String checkIn;
  final String? checkOut;
  final String? durationHours;
  final String status;
}
