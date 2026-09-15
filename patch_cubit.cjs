const fs = require('fs');

let cubitPath = 'lib/features/admin/presentation/cubit/pending_devices/admin_pending_devices_cubit.dart';
let code = fs.readFileSync(cubitPath, 'utf8');

// Fix unused import
code = code.replace("import '../../../../../core/network/api_result.dart';\n", "");

// Fix dead code
code = code.replace(/final response = await api\.getPendingDevices\(\);\n\s*if \(\(response\.isSuccess \?\? true\) == true\) \{/g, 'final response = await api.getPendingDevices();\n      if (response.isSuccess == true) {');

fs.writeFileSync(cubitPath, code);
