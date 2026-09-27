import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/core/tenant/tenant_storage.dart';
import 'package:check_point_v2/features/tenant/data/models/tenant_model.dart';

class LoginTenantBadgeWidget extends StatefulWidget {
  const LoginTenantBadgeWidget({
    this.onChangeCompany,
    super.key,
  });

  final VoidCallback? onChangeCompany;

  @override
  State<LoginTenantBadgeWidget> createState() => _LoginTenantBadgeWidgetState();
}

class _LoginTenantBadgeWidgetState extends State<LoginTenantBadgeWidget> {
  TenantModel? _tenant;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTenant();
  }

  Future<void> _loadTenant() async {
    final tenantStorage = sl<TenantStorage>();
    final tenant = await tenantStorage.readTenant();
    if (mounted) {
      setState(() {
        _tenant = tenant;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SizedBox.shrink();
    }

    final companyName = _tenant?.companyName ?? _tenant?.tenantCode ?? '';
    if (companyName.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.softBrandBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.brandPrimary.withAlpha(40),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 34.r,
            height: 34.r,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: AppColors.border),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.domain_rounded,
              size: 20.r,
              color: AppColors.brandPrimary,
            ),
          ),
          wSpace(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'tenant.lookup.currentCompany'.tr(context: context),
                  style: AppTextStyles.font11Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  companyName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.font14Bold.copyWith(
                    color: AppColors.brandInk,
                  ),
                ),
              ],
            ),
          ),
          TextButton.icon(
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: widget.onChangeCompany ??
                () {
                  Navigator.of(context).pushReplacementNamed(
                    AppRoutes.tenantLookup,
                  );
                },
            icon: Icon(
              Icons.swap_horiz_rounded,
              size: 18.r,
              color: AppColors.brandPrimary,
            ),
            label: Text(
              'tenant.lookup.changeCompany'.tr(context: context),
              style: AppTextStyles.font12Medium.copyWith(
                color: AppColors.brandPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
