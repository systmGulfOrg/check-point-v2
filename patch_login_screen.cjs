const fs = require('fs');

const path = 'lib/features/auth/presentation/screens/login_screen.dart';
let code = fs.readFileSync(path, 'utf8');

const callbackLogic = `      onDeviceTransferRequired: () {
        showDialog(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: Text('auth.login.deviceTransferTitle'.tr(context: context)),
            content: Text('auth.login.deviceTransferMessage'.tr(context: context)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: Text('auth.login.cancel'.tr(context: context)),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                  context.read<LoginCubit>().requestDeviceTransfer(
                        userName: _usernameController.text.trim(),
                        password: _passwordController.text,
                      );
                },
                child: Text('auth.login.confirmTransfer'.tr(context: context)),
              ),
            ],
          ),
        );
      },
      child: AuthShellWidget(`;

code = code.replace(
`    return LoginBlocListenerWidget(
      child: AuthShellWidget(`,
`    return LoginBlocListenerWidget(
` + callbackLogic
);

fs.writeFileSync(path, code);
