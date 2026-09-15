const fs = require('fs');
let p = 'lib/features/admin/presentation/widgets/admin_edit_employee_sheet_widget.dart';
let code = fs.readFileSync(p, 'utf8');

const insert = `
            hSpace(8),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.adminEmployeeAudit,
                    arguments: widget.employee.id,
                  );
                },
                child: Text(
                  'admin.employees.activityLog'.tr(context: context),
                  style: AppTextStyles.font14Medium.copyWith(
                    color: AppColors.brandPrimary,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            hSpace(12),
`;

code = code.replace('            hSpace(20),\n            Row(', insert + '            Row(');

fs.writeFileSync(p, code);
