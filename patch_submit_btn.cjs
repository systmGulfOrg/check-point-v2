const fs = require('fs');
let btnPath = 'lib/features/auth/presentation/widgets/login_submit_button_widget.dart';
let code = fs.readFileSync(btnPath, 'utf8');

code = code.replace("backgroundColor: rateLimitSeconds > 0 ? AppColors.placeholder : AppColors.brandPrimary,", "enabled: rateLimitSeconds == 0,");

fs.writeFileSync(btnPath, code);
