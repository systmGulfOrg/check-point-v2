import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:check_point_v2/core/core.dart';
import '../admin_employee_profile_info_card_widget.dart';

class AdminEmployeeEditPayrollCardWidget extends StatelessWidget {
  const AdminEmployeeEditPayrollCardWidget({
    required this.basicSalaryController,
    required this.allowancesController,
    required this.currencyController,
    required this.bankNameController,
    required this.bankAccountNumberController,
    required this.ibanController,
    required this.socialInsuranceNumberController,
    super.key,
  });

  final TextEditingController basicSalaryController;
  final TextEditingController allowancesController;
  final TextEditingController currencyController;
  final TextEditingController bankNameController;
  final TextEditingController bankAccountNumberController;
  final TextEditingController ibanController;
  final TextEditingController socialInsuranceNumberController;

  @override
  Widget build(BuildContext context) {
    return AdminEmployeeProfileInfoCardWidget(
      title: 'employee.profile.tabPayroll'.tr(context: context),
      icon: Icons.payments_outlined,
      children: [
        CustomTextFormField(
          controller: basicSalaryController,
          hintText: 'employee.profile.basicSalary'.tr(context: context),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          prefixIcon: const Icon(Icons.attach_money_rounded, color: AppColors.brandPrimary),
        ),
        hSpace(10),
        CustomTextFormField(
          controller: allowancesController,
          hintText: 'employee.profile.allowances'.tr(context: context),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          prefixIcon: const Icon(Icons.add_circle_outline_rounded, color: AppColors.brandPrimary),
        ),
        hSpace(10),
        CustomTextFormField(
          controller: currencyController,
          hintText: 'Currency (e.g. EGP, USD, SAR)',
          prefixIcon: const Icon(Icons.currency_exchange_rounded, color: AppColors.brandPrimary),
        ),
        hSpace(10),
        CustomTextFormField(
          controller: bankNameController,
          hintText: 'employee.profile.bankName'.tr(context: context),
          prefixIcon: const Icon(Icons.account_balance_outlined, color: AppColors.brandPrimary),
        ),
        hSpace(10),
        CustomTextFormField(
          controller: bankAccountNumberController,
          hintText: 'employee.profile.accountNumber'.tr(context: context),
          keyboardType: TextInputType.number,
          prefixIcon: const Icon(Icons.credit_card_outlined, color: AppColors.brandPrimary),
        ),
        hSpace(10),
        CustomTextFormField(
          controller: ibanController,
          hintText: 'employee.profile.iban'.tr(context: context),
          prefixIcon: const Icon(Icons.pin_outlined, color: AppColors.brandPrimary),
        ),
        hSpace(10),
        CustomTextFormField(
          controller: socialInsuranceNumberController,
          hintText: 'employee.profile.insuranceNumber'.tr(context: context),
          keyboardType: TextInputType.number,
          prefixIcon: const Icon(Icons.security_outlined, color: AppColors.brandPrimary),
        ),
      ],
    );
  }
}
