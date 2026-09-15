const fs = require('fs');
const path = 'lib/features/admin/data/apis/admin_api_service.dart';
let code = fs.readFileSync(path, 'utf8');

if (!code.includes('pending_device_model.dart')) {
  code = code.replace(
    "import 'package:check_point_v2/features/admin/data/models/shifts_policies/shift_model.dart';",
    "import 'package:check_point_v2/features/admin/data/models/shifts_policies/shift_model.dart';\nimport 'package:check_point_v2/features/admin/data/models/device/pending_device_model.dart';"
  );
}

const methodStr = `
  @GET('/api/v2/devices/pending')
  Future<PendingDevicesResponseModel> getPendingDevices();

  @POST('/api/Employee/{id}/devices')
  Future<ResultModel> approveDevice(
    @Path('id') String employeeId,
    @Body() Map<String, dynamic> body,
  );
`;

if (!code.includes('getPendingDevices')) {
  code = code.replace('}', methodStr + '}');
}

fs.writeFileSync(path, code);
