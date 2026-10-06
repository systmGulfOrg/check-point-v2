import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_state.dart';

class AdminEmployeesBlocListenerWidget extends StatelessWidget {
  const AdminEmployeesBlocListenerWidget({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) =>
      BlocListener<AdminEmployeesCubit, AdminEmployeesState>(
        listener: (context, state) {
          switch (state) {
            case AdminEmployeesStateActionSuccess(:final message):
              CustomSnackBar.showSuccess(context, message: message);
            case AdminEmployeesStateError(:final messageKey):
              CustomSnackBar.showError(
                context,
                message: messageKey.tr(context: context),
              );
            default:
              break;
          }
        },
        child: child,
      );
}
