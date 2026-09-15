import fs from 'fs';

for (let lang of ['ar', 'en']) {
    let p = `assets/translations/${lang}.json`;
    let data = JSON.parse(fs.readFileSync(p, 'utf8'));
    
    if (lang === 'ar') {
        data['admin.employees.before'] = 'كان (Before)';
        data['admin.employees.after'] = 'أصبح (After)';
        data['admin.employees.emptyValue'] = 'فارغ';
        data['admin.employees.noVisibleChanges'] = 'لا توجد تغييرات مرئية';
        data['admin.employees.activityLog'] = 'سجل النشاطات';
    } else {
        data['admin.employees.before'] = 'Before';
        data['admin.employees.after'] = 'After';
        data['admin.employees.emptyValue'] = 'Empty';
        data['admin.employees.noVisibleChanges'] = 'No visible changes';
        data['admin.employees.activityLog'] = 'Activity Log';
    }
    
    fs.writeFileSync(p, JSON.stringify(data, null, 2));
}
