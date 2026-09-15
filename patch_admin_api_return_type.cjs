const fs = require('fs');

let servicePath = 'lib/features/admin/data/apis/admin_api_service.dart';
let code = fs.readFileSync(servicePath, 'utf8');

code = code.replace(
  "Future<ResultModel> getEmployeeDevices(",
  "Future<PendingDevicesResponseModel> getEmployeeDevices("
);

fs.writeFileSync(servicePath, code);
