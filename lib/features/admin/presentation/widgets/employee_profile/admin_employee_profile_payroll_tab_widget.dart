import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'admin_employee_profile_info_card_widget.dart';
import 'admin_employee_profile_info_row_widget.dart';

class AdminEmployeeProfilePayrollTabWidget extends StatelessWidget {
  const AdminEmployeeProfilePayrollTabWidget({
    required this.employee,
    super.key,
  });

  final EmployeeModel employee;

  @override
  Widget build(BuildContext context) {
    final currency = employee.resolvedCurrency;
    final basicSalary = employee.resolvedBasicSalary;
    final allowances = employee.resolvedAllowances;
    final totalSalary = employee.resolvedTotalSalary;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        children: [
          // 1. Gross Salary Summary Card
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 16.h),
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.brandPrimary, AppColors.brandSecondary],
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
              ),
              borderRadius: BorderRadius.circular(18.r),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'employee.profile.grossSalary'.tr(context: context),
                  style: AppTextStyles.font13Medium.copyWith(
                    color: AppColors.white.withValues(alpha: 0.85),
                  ),
                ),
                hSpace(6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      NumberFormat('#,##0').format(totalSalary),
                      style: AppTextStyles.font28Bold.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    wSpace(6),
                    Text(
                      currency,
                      style: AppTextStyles.font14SemiBold.copyWith(
                        color: AppColors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
                hSpace(14),
                Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'employee.profile.basicSalary'.tr(context: context),
                            style: AppTextStyles.font11Regular.copyWith(
                              color: AppColors.white.withValues(alpha: 0.8),
                            ),
                          ),
                          hSpace(2),
                          Text(
                            '${NumberFormat('#,##0').format(basicSalary)} $currency',
                            style: AppTextStyles.font13SemiBold.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 1,
                        height: 24.h,
                        color: AppColors.white.withValues(alpha: 0.3),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'employee.profile.allowances'.tr(context: context),
                            style: AppTextStyles.font11Regular.copyWith(
                              color: AppColors.white.withValues(alpha: 0.8),
                            ),
                          ),
                          hSpace(2),
                          Text(
                            '${NumberFormat('#,##0').format(allowances)} $currency',
                            style: AppTextStyles.font13SemiBold.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 2. Bank Details Card
          AdminEmployeeProfileInfoCardWidget(
            title: 'employee.profile.sectionBank'.tr(context: context),
            icon: Icons.account_balance_outlined,
            children: [
              AdminEmployeeProfileInfoRowWidget(
                label: 'employee.profile.bankName'.tr(context: context),
                value: employee.resolvedBankName,
                icon: Icons.account_balance_rounded,
              ),
              AdminEmployeeProfileInfoRowWidget(
                label: 'employee.profile.accountNumber'.tr(context: context),
                value: employee.resolvedBankAccount,
                icon: Icons.numbers_outlined,
                isCopyable: true,
              ),
              AdminEmployeeProfileInfoRowWidget(
                label: 'employee.profile.iban'.tr(context: context),
                value: employee.resolvedIban,
                icon: Icons.vpn_key_outlined,
                isCopyable: true,
              ),
              AdminEmployeeProfileInfoRowWidget(
                label: 'employee.profile.paymentMethod'.tr(context: context),
                value: 'employee.profile.bankTransfer'.tr(context: context),
                icon: Icons.payment_outlined,
                valueColor: AppColors.success,
              ),
            ],
          ),

          // 3. Social Insurance Details
          AdminEmployeeProfileInfoCardWidget(
            title: 'employee.profile.sectionInsurance'.tr(context: context),
            icon: Icons.verified_user_outlined,
            children: [
              AdminEmployeeProfileInfoRowWidget(
                label: 'employee.profile.insuranceNumber'.tr(context: context),
                value:
                    employee.socialInsuranceNumber ??
                    'employee.profile.notRegistered'.tr(context: context),
                icon: Icons.badge_outlined,
                isCopyable: employee.socialInsuranceNumber != null,
              ),
              AdminEmployeeProfileInfoRowWidget(
                label: 'employee.profile.insuranceStatus'.tr(context: context),
                value: employee.socialInsuranceNumber != null
                    ? 'employee.profile.insured'.tr(context: context)
                    : 'employee.profile.pendingInsurance'.tr(context: context),
                icon: Icons.health_and_safety_outlined,
                valueColor: employee.socialInsuranceNumber != null
                    ? AppColors.success
                    : AppColors.warningOrange,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
