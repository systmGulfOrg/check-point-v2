const fs = require('fs');
let p = 'assets/translations/ar.json';
let obj = JSON.parse(fs.readFileSync(p, 'utf8'));
obj['admin.employees.activityLog'] = 'سجل النشاطات (Activity Log)';
fs.writeFileSync(p, JSON.stringify(obj, null, 2));

p = 'assets/translations/en.json';
obj = JSON.parse(fs.readFileSync(p, 'utf8'));
obj['admin.employees.activityLog'] = 'Activity Log';
fs.writeFileSync(p, JSON.stringify(obj, null, 2));
