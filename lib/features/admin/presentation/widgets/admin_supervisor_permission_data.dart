class AdminSupervisorPermissionData {
  const AdminSupervisorPermissionData({
    this.imageUrl,
    required this.id,
    required this.name,
    required this.email,
    required this.initials,
    required this.permissionCount,
  });

  final String? imageUrl;
  final String id;
  final String name;
  final String email;
  final String initials;
  final int permissionCount;
}
