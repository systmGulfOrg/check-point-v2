const fs = require('fs');

let servicePath = 'lib/features/admin/data/apis/admin_api_service.dart';
let code = fs.readFileSync(servicePath, 'utf8');

if (!code.includes('rejectDevice')) {
  code = code.replace(
    "@Body() Map<String, dynamic> body,\n  );",
    "@Body() Map<String, dynamic> body,\n  );\n\n  @DELETE('/employees/{employeeId}/devices/{deviceId}')\n  Future<ResultModel> rejectDevice(\n    @Path('employeeId') String employeeId,\n    @Path('deviceId') String deviceId,\n  );"
  );
  fs.writeFileSync(servicePath, code);
}

let cubitPath = 'lib/features/admin/presentation/cubit/pending_devices/admin_pending_devices_cubit.dart';
let cubitCode = fs.readFileSync(cubitPath, 'utf8');
if (!cubitCode.includes('rejectDevice(')) {
  cubitCode = cubitCode.replace(
    "class AdminPendingDevicesCubit extends Cubit<AdminPendingDevicesState> {",
    "class AdminPendingDevicesCubit extends Cubit<AdminPendingDevicesState> {\n  Future<void> rejectDevice(String employeeId, String deviceId) async {\n    try {\n      final response = await api.rejectDevice(employeeId, deviceId);\n      if (response.isSuccess == true) {\n        loadDevices();\n      } else {\n        emit(AdminPendingDevicesState.error('Reject failed'));\n      }\n    } catch (e) {\n      final failure = ApiFailureMapper.map(e);\n      emit(AdminPendingDevicesState.error(failure.messageKey));\n    }\n  }"
  );
  fs.writeFileSync(cubitPath, cubitCode);
}
