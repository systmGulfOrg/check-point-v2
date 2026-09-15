const fs = require('fs');
let p = 'lib/features/auth/presentation/screens/login_screen.dart';
let code = fs.readFileSync(p, 'utf8');

code = code.replace(
  "setState(() {\\n                _rateLimitSeconds = seconds;\\n              });",
  "setState(() {\\n                _rateLimitSeconds = seconds > 60 ? 60 : seconds;\\n              });"
);

fs.writeFileSync(p, code);
