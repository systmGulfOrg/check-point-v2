const fs = require('fs');

let cubitPath = 'lib/features/admin/presentation/cubit/pending_devices/admin_pending_devices_cubit.dart';
let cubitCode = fs.readFileSync(cubitPath, 'utf8');

cubitCode = cubitCode.replace(/ApiFailureMapper\.map\(e, st\)/g, 'ApiFailureMapper.map(e)');
cubitCode = cubitCode.replace(/failure\.userMessage/g, 'failure.messageKey');
cubitCode = cubitCode.replace(/if \(response\.isSuccess\)/g, 'if (response.isSuccess == true)');
fs.writeFileSync(cubitPath, cubitCode);

let screenPath = 'lib/features/admin/presentation/screens/admin_devices_screen.dart';
let screenCode = fs.readFileSync(screenPath, 'utf8');
screenCode = screenCode.replace(/maybeWhen/g, 'maybeMap');
screenCode = screenCode.replace(/when\(/g, 'map(');
screenCode = screenCode.replace(/initial: \(\) =>/g, 'initial: (_) =>');
screenCode = screenCode.replace(/loading: \(\) =>/g, 'loading: (_) =>');
screenCode = screenCode.replace(/error: \(msg\) =>/g, 'error: (state) =>');
screenCode = screenCode.replace(/success: \(devices\) \{/g, 'success: (state) { final devices = state.devices;');
screenCode = screenCode.replace(/error: \(msg\) \{/g, 'error: (state) { final msg = state.message;');
screenCode = screenCode.replace(/orElse: \(\) \{\}/g, 'orElse: () {}');
// wait map doesn't pass msg as parameter, it passes the state object!

// Also remove easy_localization from admin_devices_screen
screenCode = screenCode.replace("import 'package:easy_localization/easy_localization.dart';", "");

fs.writeFileSync(screenPath, screenCode);
