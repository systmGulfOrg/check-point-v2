const fs = require('fs');
let p = 'assets/translations/ar.json';
let obj = JSON.parse(fs.readFileSync(p, 'utf8'));
obj['admin.employees.by'] = 'بواسطة: ';
obj['admin.employees.unknown'] = 'غير معروف';
fs.writeFileSync(p, JSON.stringify(obj, null, 2));

p = 'assets/translations/en.json';
obj = JSON.parse(fs.readFileSync(p, 'utf8'));
obj['admin.employees.by'] = 'By: ';
obj['admin.employees.unknown'] = 'Unknown';
fs.writeFileSync(p, JSON.stringify(obj, null, 2));
