class EmployeePlanData {
  const EmployeePlanData({
    required this.id,
    required this.title,
    required this.dateTime,
    this.planType,
    this.locationName,
    this.description,
    this.status,
    this.assignees = const [],
  });

  final String id;
  final String title;
  final String dateTime;
  final String? planType;
  final String? locationName;
  final String? description;
  final String? status;
  final List<String> assignees;
}
