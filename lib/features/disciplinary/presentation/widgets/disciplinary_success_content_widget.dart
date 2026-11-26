import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:check_point_v2/core/core.dart';
import '../../data/models/disciplinary_models.dart';
import '../cubit/disciplinary_cubit.dart';
import 'disciplinary_summary_card_widget.dart';
import 'disciplinary_violation_card_widget.dart';

class DisciplinarySuccessContentWidget extends StatelessWidget {
  const DisciplinarySuccessContentWidget({
    super.key,
    required this.summary,
  });

  final DisciplinarySummaryModel summary;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DisciplinaryCubit>();

    if (summary.violations.isEmpty) {
      return RefreshIndicator(
        color: AppColors.brandPrimary,
        onRefresh: () => cubit.loadMyViolations(forMonth: cubit.currentMonth),
        child: ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            DisciplinarySummaryCardWidget(summary: summary),
            hSpace(40),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 72.r,
                    height: 72.r,
                    decoration: BoxDecoration(
                      color: AppColors.softGreenBackground,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.verified_rounded,
                      size: 40.r,
                      color: AppColors.success,
                    ),
                  ),
                  hSpace(16),
                  Text(
                    'سجل الجزاءات نظيف تماماً لهذا الشهر',
                    style: AppTextStyles.font16Bold,
                    textAlign: TextAlign.center,
                  ),
                  hSpace(6),
                  Text(
                    'لا توجد أي جزاءات أو خصومات مسجلة عليك خلال هذا الشهر',
                    style: AppTextStyles.font12Medium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      color: AppColors.brandPrimary,
      onRefresh: () => cubit.loadMyViolations(forMonth: cubit.currentMonth),
      child: ListView.builder(
        padding: EdgeInsets.all(16.r),
        itemCount: summary.violations.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: DisciplinarySummaryCardWidget(summary: summary),
            );
          }
          if (index == 1) {
            return Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Text(
                'تفاصيل الجزاءات والخصومات',
                style: AppTextStyles.font14Bold,
              ),
            );
          }
          final violation = summary.violations[index - 2];
          return DisciplinaryViolationCardWidget(
            violation: violation,
            currency: summary.currency,
            onAppeal: (reason) async {
              final ok = await cubit.submitAppeal(
                violationId: violation.id,
                reason: reason,
              );
              if (context.mounted) {
                if (ok) {
                  CustomSnackBar.showSuccess(
                    context,
                    message: 'تم إرسال التظلم بنجاح وهو قيد المراجعة',
                  );
                } else {
                  CustomSnackBar.showError(
                    context,
                    message: 'حدث خطأ أثناء إرسال التظلم، يرجى المحاولة لاحقاً',
                  );
                }
              }
            },
          );
        },
      ),
    );
  }
}
