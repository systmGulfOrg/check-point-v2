const fs = require('fs');
let code = fs.readFileSync('lib/features/auth/presentation/screens/login_screen.dart', 'utf8');

const search = `AlertDialog(
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
          )`;

const replace = `CustomDialogWidget(
            title: 'auth.login.deviceTransferTitle'.tr(context: context),
            message: 'auth.login.deviceTransferMessage'.tr(context: context),
            icon: Icons.phone_android_rounded,
            onConfirm: () {
              Navigator.pop(dialogContext);
              context.read<LoginCubit>().requestDeviceTransfer(
                    userName: _usernameController.text.trim(),
                    password: _passwordController.text,
                  );
            },
          )`;

code = code.replace(search, replace);
fs.writeFileSync('lib/features/auth/presentation/screens/login_screen.dart', code);
