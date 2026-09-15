const fs = require('fs');
let p = 'assets/translations/ar.json';
let obj = JSON.parse(fs.readFileSync(p, 'utf8'));
obj['admin.devices.pendingTitle'] = 'الأجهزة المعلقة';
obj['admin.devices.noPending'] = 'لا توجد طلبات نقل أجهزة معلقة.';
fs.writeFileSync(p, JSON.stringify(obj, null, 2));

p = 'assets/translations/en.json';
obj = JSON.parse(fs.readFileSync(p, 'utf8'));
obj['admin.devices.pendingTitle'] = 'Pending Devices';
obj['admin.devices.noPending'] = 'No pending device transfers.';
fs.writeFileSync(p, JSON.stringify(obj, null, 2));

p = 'lib/features/admin/presentation/screens/admin_devices_screen.dart';
let code = fs.readFileSync(p, 'utf8');
code = code.replace(
  "title: Text('Pending Devices', style: AppTextStyles.font18Bold),",
  "title: Text('admin.devices.pendingTitle'.tr(context: context), style: AppTextStyles.font18Bold),"
);
code = code.replace(
  "'No pending device transfers.',",
  "'admin.devices.noPending'.tr(context: context),"
);
if (!code.includes('import \'package:easy_localization/easy_localization.dart\';')) {
  code = "import 'package:easy_localization/easy_localization.dart';\n" + code;
}
fs.writeFileSync(p, code);
