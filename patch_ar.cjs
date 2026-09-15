const fs = require('fs');
let arPath = 'assets/translations/ar.json';
let data = JSON.parse(fs.readFileSync(arPath, 'utf8'));

const updates = {
  "attendance.locationLoading": "بيحمل الموقع...",
  "attendance.moveToLocationNote": "لو سمحت روح للموقع المطلوب عشان تقدر تسجل حضورك.",
  "attendance.readyNote": "موقعك مظبوط دلوقتي. تقدر تسجل حضورك.",
  "attendance.securityNote": "هنتأكد من بصمتك الأول قبل التسجيل، وبيانات حضورك محفوظة في أمان.",
  "attendance.insideArea": "أنت جوه النطاق، تقدر تسجل حضور دلوقتي",
  "attendance.outsideArea": "أنت بره النطاق، مش هينفع تسجل حضور",
  "errors.locationUnavailable": "الموقع مش متاح. شغل الـ GPS وجرب تاني.",
  "errors.outsideAttendanceArea": "أنت بره النطاق المسموح بيه للحضور.",
  "errors.biometricRequired": "لازم تأكد بصمتك عشان تكمل.",
  "errors.branchUnavailable": "مش قادرين نحمل الفرع بتاعك.",
  "errors.employeeUnavailable": "مش قادرين نحمل بياناتك.",
  "errors.employeeNotFound": "ملف الموظف مش موجود.",
  "employee.notifications.attendanceBody": "فاضل ساعة على ميعاد انصرافك.",
  "employee.notifications.tasksBody": "عندك {count} تاسكات لسه مخلصتش.",
  "admin.dashboard.todaysOverview": "ملخص النهارده",
  "admin.dashboard.thisWeek": "الأسبوع ده",
  "auth.login.subtitle": "سجل الدخول عشان تتابع الحضور وتدير موظفينك وتاسكات الـ HR.",
  "auth.login.rememberMe": "افتكرني على الجهاز ده",
  "auth.login.biometricReason": "أكد هويتك عشان تدخل حسابك",
  "auth.login.requestNote": "معندكش حساب؟ ابعت طلب تسجيل للأدمن.",
  "auth.logout.biometricWarningMessage": "تسجيل الخروج هيوقف الدخول بالبصمة على الجهاز ده. تقدر تشغله تاني لما تسجل دخول المرة الجاية.",
  "auth.requestAccess.info": "الأدمن هيراجع طلبك ويعملك الحساب. هيجيلك إشعار أول ما يوافق.",
  "auth.requestAccess.welcomeDescription": "ابعت طلب حساب والأدمن هيراجعه ويفعلهولك.",
  "errors.network": "مفيش نت. اتأكد من الاتصال وجرب تاني.",
  "errors.invalidCredentials": "بيانات الدخول غلط. جرب تاني.",
  "errors.biometricNotConfigured": "الدخول بالبصمة مش متفعل.",
  "errors.biometricFailed": "البصمة مش مظبوطة. جرب تاني.",
  "errors.server": "السيرفر واقع دلوقتي. جرب تاني كمان شوية.",
  "admin.attendance.empty": "مفيش سجلات حضور.\nجرب تغير الفلاتر.",
  "admin.attendance.deleteRecordMessage": "متأكد إنك عايز تمسح سجل الحضور ده؟ مش هينفع ترجعه تاني.",
  "leaves.dashboard.warningLowBalance": "خلي بالك: رصيد إجازاتك قرب يخلص!",
  "auth.login.deviceTransferMessage": "أنت بتسجل دخول من جهاز جديد. تحب نبعت طلب للأدمن عشان ينقل حسابك على التليفون ده؟",
  "auth.login.deviceTransferSuccess": "طلب نقل الحساب اتبعت للأدمن بنجاح. استنى الموافقة.",
  "admin.employees.leaveBalance": "رصيد الإجازات السنوي (بالأيام)",
  "admin.employees.passwordOptional": "كلمة المرور (سيبها فاضية لو مش عايز تغيرها)",
  "supervisor.dashboard.alertPending": "فيه طلب إجازة مستني موافقتك",
  "admin.requests.subtitle": "راجع طلبات الموظفين الجداد وأعملهم حساباتهم بأمان.",
  "admin.requests.rejectReasonHint": "اكتب سبب رفض الطلب ده...",
  "employee.leaves.types.incident": "إجازة عارضة",
  "employee.leaves.types.documentWorkflow": "دورة مستندية"
};

for (const key in updates) {
  if (data[key] !== undefined) {
    data[key] = updates[key];
  }
}

fs.writeFileSync(arPath, JSON.stringify(data, null, 2));
