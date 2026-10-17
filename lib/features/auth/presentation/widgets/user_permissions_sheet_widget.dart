import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/profile/auth_profile_cubit.dart';

void showUserPermissionsSheet(BuildContext context) {
  final profileCubit = context.read<AuthProfileCubit>();

  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.cardBackground,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (_) => BlocProvider.value(
      value: profileCubit,
      child: const UserPermissionsSheetWidget(),
    ),
  );
}

class UserPermissionsSheetWidget extends StatelessWidget {
  const UserPermissionsSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthProfileCubit, AuthProfileState>(
      builder: (context, state) {
        final (role, permissions) = switch (state) {
          AuthProfileSuccess(:final role, :final permissions) => (
            role,
            permissions,
          ),
          _ => ('User', <String>[]),
        };

        return SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20.w,
              18.h,
              20.w,
              MediaQuery.viewInsetsOf(context).bottom + 16.h,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const AppSheetHandleWidget(),
                  hSpace(16),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.r),
                        decoration: const BoxDecoration(
                          color: AppColors.softBrandBackground,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.shield_outlined,
                          color: AppColors.brandPrimary,
                          size: 24.r,
                        ),
                      ),
                      wSpace(12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'user.permissions.title'.tr(context: context),
                              style: AppTextStyles.font18Bold,
                            ),
                            hSpace(2),
                            Text(
                              'user.permissions.activeRole'.tr(
                                context: context,
                                namedArgs: {'role': role},
                              ),
                              style: AppTextStyles.font12Regular.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  hSpace(16),
                  if (permissions.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20.r),
                      decoration: BoxDecoration(
                        color: AppColors.pageBackground,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        'user.permissions.empty'.tr(context: context),
                        style: AppTextStyles.font14Regular,
                        textAlign: TextAlign.center,
                      ),
                    )
                  else ...[
                    Text(
                      'user.permissions.count'.tr(
                        context: context,
                        namedArgs: {'count': permissions.length.toString()},
                      ),
                      style: AppTextStyles.font13SemiBold.copyWith(
                        color: AppColors.brandPrimary,
                      ),
                    ),
                    hSpace(12),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.5,
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: permissions.length,
                        separatorBuilder: (context, index) => hSpace(8),
                        itemBuilder: (context, index) {
                          final permKey = permissions[index];
                          final label = _formatPermissionKey(context, permKey);
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 14.w,
                              vertical: 12.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.pageBackground,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_circle_rounded,
                                  color: AppColors.success,
                                  size: 18.r,
                                ),
                                wSpace(10),
                                Expanded(
                                  child: Text(
                                    label,
                                    style: AppTextStyles.font14SemiBold,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 2.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.softBrandBackground,
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  child: Text(
                                    permKey,
                                    style: AppTextStyles.font12Regular.copyWith(
                                      color: AppColors.brandPrimary,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                  hSpace(20),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: 'user.permissions.close'.tr(context: context),
                      onTap: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static String _formatPermissionKey(BuildContext context, String key) {
    final trKey = 'permissions.labels.$key';
    final translated = trKey.tr(context: context);
    if (translated != trKey) return translated;

    final parts = key.split('.');
    if (parts.length == 2) {
      final category = _capitalize(parts[0]);
      final action = _capitalize(parts[1].replaceAll('_', ' '));
      return '$category: $action';
    }
    return key;
  }

  static String _capitalize(String input) {
    if (input.isEmpty) return input;
    return '${input[0].toUpperCase()}${input.substring(1)}';
  }
}
