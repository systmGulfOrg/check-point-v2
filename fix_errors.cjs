const fs = require('fs');

let sheetPath = 'lib/features/employee/presentation/widgets/employee_details_sheet_widget.dart';
let sheetCode = fs.readFileSync(sheetPath, 'utf8');

sheetCode = sheetCode.replace(
  "final int earlyLeaveDays;\n  final String totalHours;",
  "final int earlyLeaveDays;\n  final String totalHours;\n  final List<dynamic> devicesHistory;"
);

sheetCode = sheetCode.replace(
  "required this.earlyLeaveDays,\n    required this.totalHours,",
  "required this.earlyLeaveDays,\n    required this.totalHours,\n    required this.devicesHistory,"
);

fs.writeFileSync(sheetPath, sheetCode);

let devicePath = 'lib/features/admin/presentation/screens/admin_devices_screen.dart';
let deviceCode = fs.readFileSync(devicePath, 'utf8');
if (!deviceCode.includes('CustomDialogWidget')) {
  deviceCode = deviceCode.replace(
    "import '../../../../core/core.dart';",
    "import '../../../../core/core.dart';\nimport '../../../../core/widgets/custom_dialog_widget.dart';"
  );
}
fs.writeFileSync(devicePath, deviceCode);

