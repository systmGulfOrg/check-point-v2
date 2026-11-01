import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/profile/auth_profile_cubit.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/edit_profile_sheet_widget.dart';
import 'auth_profile_card_content_widget.dart';

class AuthProfileCardWidget extends StatelessWidget {
  const AuthProfileCardWidget({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthProfileCubit, AuthProfileState>(
      builder: (context, state) {
        return switch (state) {
          AuthProfileLoading() || AuthProfileInitial() => Container(
            height: 190.h,
            decoration: BoxDecoration(
              color: AppColors.pageBackground,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: const Center(child: CircularProgressIndicator()),
          ),
          AuthProfileError(:final messageKey) => Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
              color: AppColors.softRedBackground,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Text(messageKey.tr(context: context)),
          ),
          AuthProfileSuccess(
            :final name,
            :final role,
            :final username,
            :final roles,
            :final imageUrl,
          ) =>
            Material(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(20.r),
              child: InkWell(
                onTap: onTap ?? () => showEditProfileSheet(context),
                borderRadius: BorderRadius.circular(20.r),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 20.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: AuthProfileCardContentWidget(
                    name: name,
                    username: username,
                    role: role,
                    roles: roles,
                    imageUrl: imageUrl,
                  ),
                ),
              ),
            ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}
