import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../admin_employee_profile_info_card_widget.dart';

class AdminEmployeeEditPersonalCardWidget extends StatelessWidget {
  const AdminEmployeeEditPersonalCardWidget({
    required this.nameArController,
    required this.nameEnController,
    required this.emailController,
    required this.personalEmailController,
    required this.phoneController,
    required this.secondaryPhoneController,
    required this.nationalIdController,
    required this.passportNumberController,
    required this.addressController,
    required this.cityController,
    required this.selectedGender,
    required this.selectedMaritalStatus,
    required this.idExpiryDate,
    required this.birthDate,
    required this.onGenderChanged,
    required this.onMaritalStatusChanged,
    required this.onSelectIdExpiryDate,
    required this.onSelectBirthDate,
    super.key,
  });

  final TextEditingController nameArController;
  final TextEditingController nameEnController;
  final TextEditingController emailController;
  final TextEditingController personalEmailController;
  final TextEditingController phoneController;
  final TextEditingController secondaryPhoneController;
  final TextEditingController nationalIdController;
  final TextEditingController passportNumberController;
  final TextEditingController addressController;
  final TextEditingController cityController;
  final String? selectedGender;
  final String? selectedMaritalStatus;
  final DateTime? idExpiryDate;
  final DateTime? birthDate;
  final ValueChanged<String?> onGenderChanged;
  final ValueChanged<String?> onMaritalStatusChanged;
  final VoidCallback onSelectIdExpiryDate;
  final VoidCallback onSelectBirthDate;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd');
    return AdminEmployeeProfileInfoCardWidget(
      title: 'employee.profile.sectionPersonal'.tr(context: context),
      icon: Icons.person_outline_rounded,
      children: [
        CustomTextFormField(
          controller: nameArController,
          hintText: 'employee.profile.nameAr'.tr(context: context),
          prefixIcon: const Icon(
            Icons.badge_outlined,
            color: AppColors.brandPrimary,
          ),
        ),
        hSpace(10),
        CustomTextFormField(
          controller: nameEnController,
          hintText: 'employee.profile.nameEn'.tr(context: context),
          prefixIcon: const Icon(
            Icons.badge_outlined,
            color: AppColors.brandPrimary,
          ),
        ),
        hSpace(10),
        CustomTextFormField(
          controller: emailController,
          hintText: 'employee.profile.officialEmail'.tr(context: context),
          keyboardType: TextInputType.emailAddress,
          prefixIcon: const Icon(
            Icons.email_outlined,
            color: AppColors.brandPrimary,
          ),
        ),
        hSpace(10),
        CustomTextFormField(
          controller: personalEmailController,
          hintText: 'employee.profile.personalEmail'.tr(context: context),
          keyboardType: TextInputType.emailAddress,
          prefixIcon: const Icon(
            Icons.mail_outline_rounded,
            color: AppColors.brandPrimary,
          ),
        ),
        hSpace(10),
        CustomTextFormField(
          controller: phoneController,
          hintText: 'employee.profile.primaryPhone'.tr(context: context),
          keyboardType: TextInputType.phone,
          prefixIcon: const Icon(
            Icons.phone_outlined,
            color: AppColors.brandPrimary,
          ),
        ),
        hSpace(10),
        CustomTextFormField(
          controller: secondaryPhoneController,
          hintText: 'employee.profile.secondaryPhone'.tr(context: context),
          keyboardType: TextInputType.phone,
          prefixIcon: const Icon(
            Icons.phone_android_outlined,
            color: AppColors.brandPrimary,
          ),
        ),
        hSpace(10),
        CustomTextFormField(
          controller: nationalIdController,
          hintText: 'employee.profile.nationalId'.tr(context: context),
          keyboardType: TextInputType.number,
          prefixIcon: const Icon(
            Icons.credit_card_outlined,
            color: AppColors.brandPrimary,
          ),
        ),
        hSpace(10),
        CustomTextFormField(
          controller: passportNumberController,
          hintText: 'Passport Number (رقم الجواز)',
          prefixIcon: const Icon(
            Icons.card_travel_outlined,
            color: AppColors.brandPrimary,
          ),
        ),
        hSpace(10),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: onSelectIdExpiryDate,
                borderRadius: BorderRadius.circular(10.r),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 14.h,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'employee.profile.idExpiry'.tr(context: context),
                        style: AppTextStyles.font11Regular,
                      ),
                      hSpace(2),
                      Text(
                        idExpiryDate != null
                            ? dateFormat.format(idExpiryDate!)
                            : '-',
                        style: AppTextStyles.font14Regular.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            wSpace(10),
            Expanded(
              child: InkWell(
                onTap: onSelectBirthDate,
                borderRadius: BorderRadius.circular(10.r),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 14.h,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'employee.profile.birthDate'.tr(context: context),
                        style: AppTextStyles.font11Regular,
                      ),
                      hSpace(2),
                      Text(
                        birthDate != null ? dateFormat.format(birthDate!) : '-',
                        style: AppTextStyles.font14Regular.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        hSpace(10),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                initialValue: selectedGender,
                decoration: InputDecoration(
                  labelText: 'employee.profile.gender'.tr(context: context),
                  prefixIcon: const Icon(
                    Icons.wc_outlined,
                    color: AppColors.brandPrimary,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 12.h,
                  ),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'male',
                    child: Text('Male (ذكر)', overflow: TextOverflow.ellipsis),
                  ),
                  DropdownMenuItem(
                    value: 'female',
                    child: Text(
                      'Female (أنثى)',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
                onChanged: onGenderChanged,
              ),
            ),
            wSpace(10),
            Expanded(
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                initialValue: selectedMaritalStatus,
                decoration: InputDecoration(
                  labelText: 'employee.profile.maritalStatus'.tr(
                    context: context,
                  ),
                  prefixIcon: const Icon(
                    Icons.people_outline_rounded,
                    color: AppColors.brandPrimary,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 12.h,
                  ),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'single',
                    child: Text(
                      'Single (أعزب)',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'married',
                    child: Text(
                      'Married (متزوج)',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
                onChanged: onMaritalStatusChanged,
              ),
            ),
          ],
        ),
        hSpace(10),
        CustomTextFormField(
          controller: addressController,
          hintText: 'employee.profile.address'.tr(context: context),
          prefixIcon: const Icon(
            Icons.home_outlined,
            color: AppColors.brandPrimary,
          ),
        ),
        hSpace(10),
        CustomTextFormField(
          controller: cityController,
          hintText: 'City (المدينة / المحافظة)',
          prefixIcon: const Icon(
            Icons.location_city_outlined,
            color: AppColors.brandPrimary,
          ),
        ),
      ],
    );
  }
}
