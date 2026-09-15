const fs = require('fs');
let devicePath = 'lib/features/admin/presentation/screens/admin_devices_screen.dart';
let code = fs.readFileSync(devicePath, 'utf8');

code = code.replace(/subtitle:/g, 'message:');
code = code.replace(/confirmText:/g, 'confirmLabel:');
code = code.replace(/cancelText:/g, 'cancelLabel:');
code = code.replace(/confirmColor:/g, 'confirmButtonColor:');

fs.writeFileSync(devicePath, code);
