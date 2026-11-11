import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import '../cubit/disciplinary_cubit.dart';
import '../cubit/disciplinary_state.dart';
import 'disciplinary_summary_card_widget.dart';
import 'disciplinary_violation_card_widget.dart';

class DisciplinaryViolationsBlocBuilderWidget extends StatelessWidget {
  const DisciplinaryViolationsBlocBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisciplinaryCubit, DisciplinaryState>(
      builder: (context, state) {
        return switch (state) {
          DisciplinaryStateInitial() ||
          DisciplinaryStateLoading() =>
            const Center(child: CircularProgressIndicator()),
          DisciplinaryStateError(:final messageKey) =>
            Center(child: Text(messageKey)),
          DisciplinaryStateSuccess(:final summary) => _buildSuccessContent(
            context,
            summary,
          ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }

  Widget _buildSuccessContent(
    BuildContext context,
    dynamic summary,
  ) {
    if (summary.violations.isEmpty) {
      return RefreshIndicator(
        onRefresh: () => context.read<DisciplinaryCubit>().loadMyViolations(),
        child: ListView(
          padding: EdgeInsets.all(16.w),
          children: [
            DisciplinarySummaryCardWidget(summary: summary),
            SizedBox(height: 60.h),
            Center(
              child: Column(
                children: [
                  Icon(Icons.verified_outlined, size: 64.sp, color: Colors.green),
                  SizedBox(height: 12.h),
                  Text(
                    'سجل الجزاءات نظيف تماماً لهذا الشهر',
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => context.read<DisciplinaryCubit>().loadMyViolations(),
      child: ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: summary.violations.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: DisciplinarySummaryCardWidget(summary: summary),
            );
          }
          final violation = summary.violations[index - 1];
          return DisciplinaryViolationCardWidget(
            violation: violation,
            onAppeal: (reason) {
              context.read<DisciplinaryCubit>().submitAppeal(
                    violationId: violation.id,
                    reason: reason,
                  );
            },
          );
        },
      ),
    );
  }
}
