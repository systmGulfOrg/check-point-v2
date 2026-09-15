const fs = require('fs');

let empP = 'lib/features/admin/presentation/cubit/employee/admin_employees_cubit.dart';
let empCode = fs.readFileSync(empP, 'utf8');

empCode = empCode.replace('Future<bool> editEmployee(', 'Future<String?> editEmployee(');
empCode = empCode.replace(/return result\.when\([\s\S]*?success: \(_\) async \{[\s\S]*?return true;[\s\S]*?\},[\s\S]*?failure: \(failure\) \{[\s\S]*?emit\(AdminEmployeesState\.error\(failure\.messageKey\)\);[\s\S]*?return false;[\s\S]*?\},[\s\S]*?\);/g, (match) => {
    return match.replace('return true;', 'return null;').replace('return false;', 'return failure.messageKey;');
});
fs.writeFileSync(empP, empCode);

let p = 'lib/features/admin/presentation/screens/admin_create_employee_screen.dart';
let code = fs.readFileSync(p, 'utf8');
code = code.replace(/saveErrorMessage = errorMessage \?\? 'admin\.employeeWizard\.createFailed';/g, "saveErrorMessage = errorMessage;");
fs.writeFileSync(p, code);
