import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/core/core.dart';

class AdminCustomerVisitsSkeletonWidget extends StatelessWidget {
  const AdminCustomerVisitsSkeletonWidget({this.itemCount = 3, super.key});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('سجل الزيارات', style: AppTextStyles.font12Regular),
              Text(
                '+ خطة زيارة جديدة',
                style: AppTextStyles.font12Bold.copyWith(
                  color: AppColors.brandPrimary,
                ),
              ),
            ],
          ),
          hSpace(8),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: itemCount,
            separatorBuilder: (context, index) => hSpace(12),
            itemBuilder: (context, index) => Container(
              padding: EdgeInsets.all(14.r),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: AppColors.border),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.more_vert,
                        size: 20.r,
                        color: AppColors.placeholder,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.softBrandBackground,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('مجدولة', style: AppTextStyles.font12SemiBold),
                            wSpace(4),
                            Icon(Icons.schedule, size: 14.r),
                          ],
                        ),
                      ),
                    ],
                  ),
                  hSpace(8),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 14.r,
                        color: AppColors.textSecondary,
                      ),
                      wSpace(6),
                      Text(
                        '2026-10-15 • 12:00 م',
                        style: AppTextStyles.font12Regular,
                      ),
                    ],
                  ),
                  hSpace(6),
                  Row(
                    children: [
                      Icon(
                        Icons.business_outlined,
                        size: 14.r,
                        color: AppColors.brandPrimary,
                      ),
                      wSpace(6),
                      Text(
                        'اسم الشركة أو العميل التجاري',
                        style: AppTextStyles.font13SemiBold.copyWith(
                          color: AppColors.brandPrimary,
                        ),
                      ),
                    ],
                  ),
                  hSpace(6),
                  Text(
                    'تسليم المشروع ومناقشة تفاصيل العمل',
                    style: AppTextStyles.font14Bold,
                  ),
                  hSpace(6),
                  Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 14.r,
                        color: AppColors.textSecondary,
                      ),
                      wSpace(6),
                      Text(
                        'تمت الجدولة بواسطة: أحمد محمد',
                        style: AppTextStyles.font12Regular,
                      ),
                    ],
                  ),
                  hSpace(6),
                  Row(
                    children: [
                      Icon(
                        Icons.group_outlined,
                        size: 14.r,
                        color: AppColors.textSecondary,
                      ),
                      wSpace(6),
                      Expanded(
                        child: Text(
                          'المرافقون / الحاضرون: محمد علي • مطور برمجيات',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.font12Regular,
                        ),
                      ),
                    ],
                  ),
                  hSpace(14),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 38.h,
                          decoration: BoxDecoration(
                            color: AppColors.brandPrimary,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'تسجيل حضور الزيارة',
                            style: AppTextStyles.font13SemiBold.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                      wSpace(10),
                      Container(
                        height: 38.h,
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        decoration: BoxDecoration(
                          color: AppColors.pageBackground,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: AppColors.border),
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.history, size: 16.r),
                            wSpace(4),
                            Text(
                              'سجل النشاط',
                              style: AppTextStyles.font12Regular,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
