const fs = require('fs');
let code = fs.readFileSync('lib/core/network/api_failure_mapper.dart', 'utf8');

code = code.replace(
  "      if ((message.contains('device') || message.contains('devise'))) {",
  "      if ((message.contains('device') || message.contains('devise')) && message.contains('access') && message.contains('login')) {"
);

fs.writeFileSync('lib/core/network/api_failure_mapper.dart', code);
