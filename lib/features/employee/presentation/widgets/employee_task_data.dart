class EmployeeTaskData {
  const EmployeeTaskData({
    required this.id,
    required this.title,
    required this.dueDate,
    required this.status,
    this.priority,
    this.description,
    this.progressPercentage,
    this.assignees = const [],
  });

  final String id;
  final String title;
  final String dueDate;
  final String status;
  final String? priority;
  final String? description;
  final int? progressPercentage;
  final List<String> assignees;
}
