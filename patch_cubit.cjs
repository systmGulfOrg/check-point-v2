const fs = require('fs');

let cubitPath = 'lib/features/admin/presentation/cubit/pending_devices/admin_pending_devices_cubit.dart';
let code = fs.readFileSync(cubitPath, 'utf8');

code = code.replace(/if \(response\.isSuccess == true\) \{/g, 'if ((response.isSuccess ?? true) == true) {');

fs.writeFileSync(cubitPath, code);
