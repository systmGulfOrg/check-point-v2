const fs = require('fs');
const path = 'lib/features/admin/data/apis/admin_api_service.dart';
let code = fs.readFileSync(path, 'utf8');

code = code.replace(
  "@POST('/api/Employee/{id}/devices')",
  "@POST('/api/v2/employees/{id}/devices')"
);

fs.writeFileSync(path, code);
