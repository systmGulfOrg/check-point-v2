import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:check_point_v2/core/core.dart';
import '../../data/models/disciplinary_models.dart';

class DisciplinarySummaryCardWidget extends StatelessWidget {
  const DisciplinarySummaryCardWidget({super.key, required this.summary});

  final DisciplinarySummaryModel summary;

  String _formatCurrency(String currency) {
    if (currency.toUpperCase() == 'SAR') return 'ر.س';
    if (currency.toUpperCase() == 'EGP') return 'ج.م';
    if (currency.toUpperCase() == 'AED') return 'د.إ';
    if (currency.toUpperCase() == 'USD') return '\$';
    return currency;
  }

  @override
  Widget build(BuildContext context) {
    final currencyLabel = _formatCurrency(summary.currency);
    final hasViolations = summary.violationsCount > 0;

    return AppCardContainerWidget(
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 36.r,
                    height: 36.r,
                    decoration: BoxDecoration(
                      color: hasViolations
                          ? AppColors.softRedBackground
                          : AppColors.softGreenBackground,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      hasViolations
                          ? Icons.gavel_rounded
                          : Icons.verified_user_rounded,
                      size: 20.r,
                      color: hasViolations ? AppColors.error : AppColors.success,
                    ),
                  ),
                  wSpace(10),
                  Text(
                    'ملخص الجزاءات والخصومات',
                    style: AppTextStyles.font14Bold,
                  ),
                ],
              ),
              AppStatusPillWidget(
                label: hasViolations
                    ? '${summary.violationsCount} ${summary.violationsCount == 1 ? 'مخالفة' : 'مخالفات'}'
                    : 'سجل نظيف',
                color: hasViolations ? AppColors.error : AppColors.success,
                backgroundColor: hasViolations
                    ? AppColors.softRedBackground
                    : AppColors.softGreenBackground,
              ),
            ],
          ),
          hSpace(16),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: AppColors.softOrangeLightBackground,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColors.brandPrimary.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            size: 14.r,
                            color: AppColors.brandPrimary,
                          ),
                          wSpace(4),
                          Text(
                            'الأيام المخصومة',
                            style: AppTextStyles.font11Medium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      hSpace(6),
                      Text(
                        summary.totalDeductedDays == 0
                            ? '0 يوم'
                            : '${summary.totalDeductedDays} يوم',
                        style: AppTextStyles.font16Bold.copyWith(
                          color: AppColors.brandPrimaryDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              wSpace(12),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: AppColors.softRedBackground.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColors.error.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.account_balance_wallet_outlined,
                            size: 14.r,
                            color: AppColors.error,
                          ),
                          wSpace(4),
                          Text(
                            'القيمة المالية',
                            style: AppTextStyles.font11Medium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      hSpace(6),
                      Text(
                        '${summary.totalCalculatedAmount.toStringAsFixed(summary.totalCalculatedAmount.truncateToDouble() == summary.totalCalculatedAmount ? 0 : 2)} $currencyLabel',
                        style: AppTextStyles.font16Bold.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
