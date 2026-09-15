const fs = require('fs');
let p = 'lib/core/di/service_locator.dart';
let code = fs.readFileSync(p, 'utf8');

if (!code.includes('AdminEmployeeAuditCubit(api:')) {
  // Find the last closing brace
  const lastBraceIndex = code.lastIndexOf('}');
  if (lastBraceIndex !== -1) {
    code = code.substring(0, lastBraceIndex) + "  sl.registerFactory(() => AdminEmployeeAuditCubit(api: sl()));\n" + code.substring(lastBraceIndex);
    fs.writeFileSync(p, code);
  }
}
