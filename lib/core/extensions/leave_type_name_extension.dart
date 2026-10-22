import 'package:easy_localization/easy_localization.dart';

extension LeaveTypeNameExtension on String {
  String get localizedLeaveTypeName {
    final key = switch (trim().toLowerCase()) {
      'annual leave' || 'annual' => 'leaves.types.annual',
      'casual leave' || 'casual' => 'leaves.types.casual',
      'sick leave' || 'sick' => 'leaves.types.sick',
      'unpaid leave' || 'unpaid' => 'leaves.types.unpaid',
      _ => null,
    };
    return key == null ? this : key.tr();
  }
}
