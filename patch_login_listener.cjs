const fs = require('fs');

const path = 'lib/features/auth/presentation/widgets/login_bloc_listener_widget.dart';
let code = fs.readFileSync(path, 'utf8');

code = code.replace(
`class LoginBlocListenerWidget extends StatelessWidget {
  const LoginBlocListenerWidget({required this.child, super.key});

  final Widget child;`,
`class LoginBlocListenerWidget extends StatelessWidget {
  const LoginBlocListenerWidget({
    required this.child,
    required this.onDeviceTransferRequired,
    super.key,
  });

  final Widget child;
  final VoidCallback onDeviceTransferRequired;`
);

code = code.replace(
`        case LoginError(:final messageKey):
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(messageKey.tr(context: context))),
          );`,
`        case LoginError(:final messageKey):
          if (messageKey == 'deviceTransferSuccess') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('auth.login.deviceTransferSuccess'.tr(context: context))),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(messageKey.tr(context: context))),
            );
          }
        case LoginDeviceTransferRequired():
          onDeviceTransferRequired();`
);

fs.writeFileSync(path, code);
