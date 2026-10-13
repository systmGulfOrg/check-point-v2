import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/points_badge_model.dart';
import '../cubit/points_cubit.dart';
import '../cubit/points_state.dart';

class BadgesScreen extends StatelessWidget {
  const BadgesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        title: Text(
          'points.badgesTitle'.tr(context: context),
          style: AppTextStyles.font18Bold,
        ),
        centerTitle: true,
        backgroundColor: AppColors.cardBackground,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => context.read<PointsCubit>().loadAllPointsData(),
          ),
        ],
      ),
      body: BlocBuilder<PointsCubit, PointsState>(
        builder: (context, state) {
          return switch (state) {
            PointsLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            PointsError(:final message) => Center(
              child: Padding(
                padding: EdgeInsets.all(24.r),
                child: Text(message, style: AppTextStyles.font14Regular),
              ),
            ),
            PointsLoaded(:final badges) => badges.isEmpty
                ? Center(
                    child: Text(
                      'points.emptyBadges'.tr(context: context),
                      style: AppTextStyles.font14Regular.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () => context.read<PointsCubit>().loadAllPointsData(),
                    child: GridView.builder(
                      padding: EdgeInsets.all(16.r),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12.w,
                        mainAxisSpacing: 12.h,
                        childAspectRatio: 0.78,
                      ),
                      itemCount: badges.length,
                      itemBuilder: (context, index) {
                        final badge = badges[index];
                        return _BadgeCard(badge: badge, isArabic: isArabic);
                      },
                    ),
                  ),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }
}

class _BadgeCard extends StatelessWidget {
  const _BadgeCard({
    required this.badge,
    required this.isArabic,
  });

  final PointsBadgeItemModel badge;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final isUnlocked = badge.isUnlocked;
    final title = isArabic ? badge.titleAr : badge.title;
    final description = isArabic ? badge.descriptionAr : badge.description;

    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: isUnlocked
              ? AppColors.warningOrange.withValues(alpha: 0.5)
              : AppColors.border,
          width: isUnlocked ? 1.5 : 1.0,
        ),
        boxShadow: isUnlocked
            ? [
                BoxShadow(
                  color: AppColors.warningOrange.withValues(alpha: 0.1),
                  blurRadius: 8.r,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon
          Container(
            width: 56.r,
            height: 56.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isUnlocked
                  ? AppColors.warningOrange.withValues(alpha: 0.15)
                  : AppColors.border.withValues(alpha: 0.3),
            ),
            child: Icon(
              _getBadgeIcon(badge.icon),
              size: 30.r,
              color: isUnlocked ? AppColors.warningOrange : AppColors.textSecondary,
            ),
          ),
          hSpace(10),

          // Title
          Text(
            title,
            style: AppTextStyles.font14Bold.copyWith(
              color: isUnlocked ? AppColors.textPrimary : AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          hSpace(4),

          // Description
          Text(
            description,
            style: AppTextStyles.font10Medium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          hSpace(10),

          // Status / Progress
          if (isUnlocked) ...[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(
                'points.unlockedAt'.tr(
                  context: context,
                  args: [badge.unlockedAt ?? ''],
                ),
                style: AppTextStyles.font10Medium.copyWith(
                  color: AppColors.success,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ] else ...[
            // Progress Bar
            LinearProgressIndicator(
              value: badge.progressPercentage.clamp(0.0, 1.0),
              backgroundColor: AppColors.border,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.brandPrimary),
              minHeight: 5.h,
              borderRadius: BorderRadius.circular(3.r),
            ),
            hSpace(4),
            Text(
              'points.progress'.tr(
                context: context,
                args: ['${badge.currentProgress}', '${badge.targetProgress}'],
              ),
              style: AppTextStyles.font10Medium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  IconData _getBadgeIcon(String iconKey) {
    return switch (iconKey.toLowerCase()) {
      'falcon' || 'flight' => Icons.flight_takeoff_rounded,
      'shield' || 'disciplined' => Icons.verified_rounded,
      'life_ring' || 'rescuer' => Icons.healing_rounded,
      'star' || 'committed' => Icons.military_tech_rounded,
      _ => Icons.workspace_premium_rounded,
    };
  }
}
