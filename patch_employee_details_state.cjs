const fs = require('fs');

let statePath = 'lib/features/employee/presentation/cubit/details/employee_details_state.dart';
let stateCode = fs.readFileSync(statePath, 'utf8');

if (!stateCode.includes('devicesHistory')) {
  stateCode = stateCode.replace(
    "import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';",
    "import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';\nimport 'package:check_point_v2/features/admin/data/models/device/pending_device_model.dart';"
  );
  stateCode = stateCode.replace(
    "required String totalHours,",
    "required String totalHours,\n    @Default([]) List<PendingDeviceModel> devicesHistory,"
  );
  fs.writeFileSync(statePath, stateCode);
}
