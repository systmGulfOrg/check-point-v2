import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:check_point_v2/core/core.dart';
import '../cubit/disciplinary_cubit.dart';
import '../cubit/disciplinary_state.dart';
import 'disciplinary_month_picker_widget.dart';
import 'disciplinary_success_content_widget.dart';

class DisciplinaryViolationsBlocBuilderWidget extends StatelessWidget {
  const DisciplinaryViolationsBlocBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DisciplinaryCubit>();

    return BlocBuilder<DisciplinaryCubit, DisciplinaryState>(
      builder: (context, state) {
        return Column(
          children: [
            DisciplinaryMonthPickerWidget(cubit: cubit),
            Expanded(
              child: switch (state) {
                DisciplinaryStateInitial() ||
                DisciplinaryStateLoading() =>
                  const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.brandPrimary,
                    ),
                  ),
                DisciplinaryStateError(:final messageKey) =>
                  AppErrorStateWidget(
                    messageKey: messageKey,
                    onRetry: () =>
                        cubit.loadMyViolations(forMonth: cubit.currentMonth),
                  ),
                DisciplinaryStateSuccess(:final summary) =>
                  DisciplinarySuccessContentWidget(summary: summary),
                _ => const SizedBox.shrink(),
              },
            ),
          ],
        );
      },
    );
  }
}
