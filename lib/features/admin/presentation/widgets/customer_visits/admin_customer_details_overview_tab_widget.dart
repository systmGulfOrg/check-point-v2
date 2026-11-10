import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_response_model.dart';
import 'admin_customer_details_info_row_widget.dart';

class AdminCustomerDetailsOverviewTabWidget extends StatelessWidget {
  const AdminCustomerDetailsOverviewTabWidget({
    super.key,
    required this.customer,
    required this.scrollController,
  });

  final CustomerModel customer;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: scrollController,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      children: [
        Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'البيانات الجغرافية والنطاق',
                style: AppTextStyles.font14Bold,
              ),
              SizedBox(height: 12.h),
              AdminCustomerDetailsInfoRowWidget(
                icon: Icons.title_rounded,
                label: 'اسم العميل / المؤسسة',
                value: customer.name ?? '-',
              ),
              const Divider(color: AppColors.border),
              AdminCustomerDetailsInfoRowWidget(
                icon: Icons.category_outlined,
                label: 'طبيعة النشاط / يعمل كـ',
                value: customer.workesAs ?? '-',
              ),
              const Divider(color: AppColors.border),
              AdminCustomerDetailsInfoRowWidget(
                icon: Icons.map_outlined,
                label: 'العنوان الجغرافي',
                value: customer.location ?? '-',
              ),
              const Divider(color: AppColors.border),
              AdminCustomerDetailsInfoRowWidget(
                icon: Icons.gps_fixed_rounded,
                label: 'حالة السياج الجغرافي (Geofence)',
                value: (customer.coordinates?.isNotEmpty ?? false)
                    ? 'مفعل ومحدد بنقاط جغرافية'
                    : 'غير محدد',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
