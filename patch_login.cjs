const fs = require('fs');
let screenPath = 'lib/features/auth/presentation/screens/login_screen.dart';
let code = fs.readFileSync(screenPath, 'utf8');

// Add Timer import if needed
if (!code.includes("import 'dart:async';")) {
  code = "import 'dart:async';\n" + code;
}

// Add state variables to _LoginScreenState
const stateVars = `
  int _rateLimitSeconds = 0;
  Timer? _rateLimitTimer;
`;

code = code.replace(/bool _obscurePassword = true;\n\s*bool _enableBiometricLogin = false;/, "bool _obscurePassword = true;\n  bool _enableBiometricLogin = false;" + stateVars);

// Cleanup timer in dispose
code = code.replace(/_usernameController\.dispose\(\);/, "_rateLimitTimer?.cancel();\n    _usernameController.dispose();");

// Add listener logic in LoginBlocListenerWidget
const listenerReplacement = `
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        state.maybeWhen(
          error: (msg) {
            if (msg.toLowerCase().contains('rate limit') || msg.toLowerCase().contains('retry in')) {
              setState(() {
                _rateLimitSeconds = 60;
              });
              _rateLimitTimer?.cancel();
              _rateLimitTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
                if (_rateLimitSeconds > 0) {
                  setState(() {
                    _rateLimitSeconds--;
                  });
                } else {
                  timer.cancel();
                }
              });
            }
          },
          orElse: () {},
        );
      },
      child: LoginBlocListenerWidget(
`;

code = code.replace("    return LoginBlocListenerWidget(", listenerReplacement);

// Update LoginSubmitButtonWidget
code = code.replace("                    LoginSubmitButtonWidget(\n                      onSubmit: () {", "                    LoginSubmitButtonWidget(\n                      rateLimitSeconds: _rateLimitSeconds,\n                      onSubmit: () {");

code = code.replace(/onSubmit: \(\) \{\n\s*if \(!\(formKey\.currentState\?\.validate\(\) \?\? false\)\) \{/, "onSubmit: () {\n                        if (_rateLimitSeconds > 0) return;\n                        if (!(formKey.currentState?.validate() ?? false)) {");

fs.writeFileSync(screenPath, code);
