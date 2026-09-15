const fs = require('fs');
const path = 'lib/features/admin/presentation/cubit/pending_devices/admin_pending_devices_cubit.dart';
let code = fs.readFileSync(path, 'utf8');

code = code.replace(
  "import '../../../../core/network/api_result.dart';",
  "import '../../../../../core/network/api_result.dart';"
);
code = code.replace(
  "import '../../../../core/network/api_failure_mapper.dart';",
  "import '../../../../../core/network/api_failure_mapper.dart';"
);
code = code.replace(
  "response.message ?? 'Approval failed'",
  "'Approval failed'"
);
fs.writeFileSync(path, code);
