const fs = require('fs');
let p = 'lib/features/admin/presentation/screens/admin_create_employee_screen.dart';
let code = fs.readFileSync(p, 'utf8');

// Replace the approveRequest logic
code = code.replace(/final success = await accountRequestsCubit\.approveRequest\([\s\S]*?body: approveBody,[\s\S]*?\);[\s\S]*?if \(!mounted\) return;[\s\S]*?if \(success\) \{/m, `final errorMessage = await accountRequestsCubit.approveRequest(
                              id: widget.accountRequest!.id!,
                              body: approveBody,
                            );

                            if (!mounted) return;
                            if (errorMessage == null) {`);

code = code.replace(/saveErrorMessage = 'admin\.employeeWizard\.createFailed';/g, "saveErrorMessage = errorMessage ?? 'admin.employeeWizard.createFailed';");

// Replace the addEmployee logic
code = code.replace(/final success = await employeesCubit\.addEmployee\(addBody\);[\s\S]*?if \(!mounted\) return;[\s\S]*?if \(success\) \{/m, `final errorMessage = await employeesCubit.addEmployee(addBody);
                          if (!mounted) return;
                          if (errorMessage == null) {`);

fs.writeFileSync(p, code);
