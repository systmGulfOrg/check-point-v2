const fs = require('fs');
let cubitPath = 'lib/features/employee/presentation/cubit/details/employee_details_cubit.dart';
let code = fs.readFileSync(cubitPath, 'utf8');

if (!code.includes('devicesHistory')) {
  code = code.replace(
    "import 'employee_details_state.dart';",
    "import 'employee_details_state.dart';\nimport 'package:check_point_v2/core/di/service_locator.dart';\nimport 'package:check_point_v2/features/admin/data/apis/admin_api_service.dart';\nimport 'package:check_point_v2/features/admin/data/models/device/pending_device_model.dart';"
  );
  code = code.replace(
    "DateTime selectedMonth = DateTime(DateTime.now().year, DateTime.now().month);",
    "DateTime selectedMonth = DateTime(DateTime.now().year, DateTime.now().month);\n  List<PendingDeviceModel> devicesHistory = [];"
  );
  code = code.replace(
    "employee = (profileResult as Success).data;",
    "employee = (profileResult as Success).data;\n    try {\n      final devicesResponse = await sl<AdminApiService>().getEmployeeDevices(employeeId);\n      if (devicesResponse.isSuccess) {\n        devicesHistory = devicesResponse.value;\n      }\n    } catch (_) {}"
  );
  code = code.replace(
    "totalHours: _totalHours(monthlyRecords),",
    "totalHours: _totalHours(monthlyRecords),\n        devicesHistory: devicesHistory,"
  );
  fs.writeFileSync(cubitPath, code);
}
