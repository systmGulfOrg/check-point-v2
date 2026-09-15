const fs = require('fs');
let servicePath = 'lib/features/admin/data/apis/admin_api_service.dart';
let code = fs.readFileSync(servicePath, 'utf8');

if (!code.includes('getEmployeeDevices')) {
  code = code.replace(
    "@GET('/api/v2/devices/pending')",
    "@GET('/api/v2/employees/{id}/devices')\n  Future<ResultModel> getEmployeeDevices(\n    @Path('id') String employeeId,\n  );\n\n  @GET('/api/v2/devices/pending')"
  );
  fs.writeFileSync(servicePath, code);
}
