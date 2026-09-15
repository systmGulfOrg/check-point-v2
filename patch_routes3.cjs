const fs = require('fs');

let appRoutesPath = 'lib/core/routes/routes.dart';
let codeRoutes = fs.readFileSync(appRoutesPath, 'utf8');
if (!codeRoutes.includes('adminPendingDevices')) {
  codeRoutes = codeRoutes.replace(
    "static const String adminTasks = '/admin/tasks';",
    "static const String adminTasks = '/admin/tasks';\n  static const String adminPendingDevices = '/admin/pending-devices';"
  );
  fs.writeFileSync(appRoutesPath, codeRoutes);
}
