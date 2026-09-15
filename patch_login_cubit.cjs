const fs = require('fs');

const path = 'lib/features/auth/presentation/cubit/login/login_cubit.dart';
let code = fs.readFileSync(path, 'utf8');

code = code.replace(
`      case Failure<LoginResponseModel>(:final failure):
        emit(LoginState.error(failure.messageKey));`,
`      case Failure<LoginResponseModel>(:final failure):
        if (failure.messageKey == 'errors.deviceLoginAccess') {
          emit(const LoginState.deviceTransferRequired());
        } else {
          emit(LoginState.error(failure.messageKey));
        }`
);

fs.writeFileSync(path, code);
