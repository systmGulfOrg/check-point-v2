const fs = require('fs');
let p = 'lib/core/network/api_failure_mapper.dart';
let code = fs.readFileSync(p, 'utf8');

let replacement = `_ when status == 403 => ApiFailure(
          messageKey: messages.any((m) => m.toLowerCase().contains('device is not registered'))
              ? 'errors.deviceLoginAccess'
              : 'errors.forbidden',
        ),`;

code = code.replace(/_ when status == 403 => const ApiFailure\(\s*messageKey: 'errors\.forbidden',\s*\),/, replacement);

fs.writeFileSync(p, code);
