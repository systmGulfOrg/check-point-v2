const fs = require('fs');
const path = 'lib/features/admin/data/apis/admin_api_service.dart';
let code = fs.readFileSync(path, 'utf8');

code = code.replace(`  factory AdminApiService(Dio dio, {String? baseUrl
  @GET('/api/v2/devices/pending')
  Future<PendingDevicesResponseModel> getPendingDevices();

  @POST('/api/v2/employees/{id}/devices')
  Future<ResultModel> approveDevice(
    @Path('id') String employeeId,
    @Body() Map<String, dynamic> body,
  );
}) = _AdminApiService;`, `  factory AdminApiService(Dio dio, {String? baseUrl}) = _AdminApiService;
  
  @GET('/api/v2/devices/pending')
  Future<PendingDevicesResponseModel> getPendingDevices();

  @POST('/api/v2/employees/{id}/devices')
  Future<ResultModel> approveDevice(
    @Path('id') String employeeId,
    @Body() Map<String, dynamic> body,
  );
`);

fs.writeFileSync(path, code);
