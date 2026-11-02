class EmployeeAttendanceRecordData {
  const EmployeeAttendanceRecordData({
    required this.date,
    required this.checkIn,
    this.day,
    this.checkOut,
    this.area,
    this.durationHours,
    this.isLate = false,
    this.isEarly = false,
    this.rawDate,
  });

  final String date;
  final DateTime? day;
  final String checkIn;
  final String? checkOut;
  final String? area;
  final String? durationHours;
  final bool isLate;
  final bool isEarly;
  final String? rawDate;
}
