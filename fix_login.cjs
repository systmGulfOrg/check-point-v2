const fs = require('fs');
let p = 'lib/features/auth/presentation/screens/login_screen.dart';
let code = fs.readFileSync(p, 'utf8');

if (!code.includes("import 'package:check_point_v2/features/auth/presentation/cubit/login/login_state.dart';")) {
  code = "import 'package:check_point_v2/features/auth/presentation/cubit/login/login_state.dart';\n" + code;
}

code = code.replace("        ),\n      ),\n    );\n  }\n}", "        ),\n      ),\n    ));\n  }\n}");

fs.writeFileSync(p, code);
