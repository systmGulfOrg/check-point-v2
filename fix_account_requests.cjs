const fs = require('fs');
let p = 'lib/features/admin/presentation/cubit/account_requests/admin_account_requests_cubit.dart';
let code = fs.readFileSync(p, 'utf8');

code = code.replace(/return result\.when\([\s\S]*?success: \(_\) async \{[\s\S]*?return true;[\s\S]*?\},[\s\S]*?failure: \(failure\) \{[\s\S]*?emit\(AdminAccountRequestsState\.error\(failure\.messageKey\)\);[\s\S]*?return false;[\s\S]*?\},[\s\S]*?\);/g, (match) => {
    return match.replace('return true;', 'return null;').replace('return false;', 'return failure.messageKey;');
});
fs.writeFileSync(p, code);

// Fix usages in UI
function replaceInUi(file) {
    let code = fs.readFileSync(file, 'utf8');
    code = code.replace(/await context\.read<AdminAccountRequestsCubit>\(\)\.deleteRequest\([\s\S]*?\)/g, (match) => {
        return `(${match} == null)`;
    });
    code = code.replace(/await context\.read<AdminAccountRequestsCubit>\(\)\.rejectRequest\([\s\S]*?\)/g, (match) => {
        return `(${match} == null)`;
    });
    fs.writeFileSync(file, code);
}

replaceInUi('lib/features/admin/presentation/screens/admin_request_details_screen.dart');
replaceInUi('lib/features/admin/presentation/widgets/admin_account_requests_bloc_builder_widget.dart');
