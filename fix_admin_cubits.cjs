const fs = require('fs');

// Fix AdminEmployeesCubit
let empP = 'lib/features/admin/presentation/cubit/employee/admin_employees_cubit.dart';
let empCode = fs.readFileSync(empP, 'utf8');

empCode = empCode.replace('Future<bool> addEmployee(AddEmployeeRequestBody body) async {', 'Future<String?> addEmployee(AddEmployeeRequestBody body) async {');
empCode = empCode.replace(/return result\.when\([\s\S]*?success: \(_\) async \{[\s\S]*?return true;[\s\S]*?\},[\s\S]*?failure: \(failure\) \{[\s\S]*?emit\(AdminEmployeesState\.error\(failure\.messageKey\)\);[\s\S]*?return false;[\s\S]*?\},[\s\S]*?\);/, (match) => {
    return match.replace('return true;', 'return null;').replace('return false;', 'return failure.messageKey;');
});

empCode = empCode.replace('Future<bool> updateEmployee(', 'Future<String?> updateEmployee(');
empCode = empCode.replace(/return result\.when\([\s\S]*?success: \(_\) async \{[\s\S]*?return true;[\s\S]*?\},[\s\S]*?failure: \(failure\) \{[\s\S]*?emit\(AdminEmployeesState\.error\(failure\.messageKey\)\);[\s\S]*?return false;[\s\S]*?\},[\s\S]*?\);/, (match) => {
    return match.replace('return true;', 'return null;').replace('return false;', 'return failure.messageKey;');
});

fs.writeFileSync(empP, empCode);

// Fix AdminAccountRequestsCubit
let reqP = 'lib/features/admin/presentation/cubit/account_requests/admin_account_requests_cubit.dart';
let reqCode = fs.readFileSync(reqP, 'utf8');

reqCode = reqCode.replace('Future<bool> approveRequest({', 'Future<String?> approveRequest({');
reqCode = reqCode.replace(/return result\.when\([\s\S]*?success: \(_\) async \{[\s\S]*?return true;[\s\S]*?\},[\s\S]*?failure: \(failure\) \{[\s\S]*?emit\(AdminAccountRequestsState\.error\(failure\.messageKey\)\);[\s\S]*?return false;[\s\S]*?\},[\s\S]*?\);/, (match) => {
    return match.replace('return true;', 'return null;').replace('return false;', 'return failure.messageKey;');
});

fs.writeFileSync(reqP, reqCode);
