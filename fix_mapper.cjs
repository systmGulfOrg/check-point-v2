const fs = require('fs');
let p = 'lib/core/network/api_failure_mapper.dart';
let code = fs.readFileSync(p, 'utf8');

code = code.replace(/_ when status == 400 => const ApiFailure\(\s*messageKey: 'errors\.validation',\s*\),/, "_ when status == 400 => ApiFailure(\n          messageKey: messages.isNotEmpty ? messages.join(' ') : 'errors.validation',\n        ),");

fs.writeFileSync(p, code);
