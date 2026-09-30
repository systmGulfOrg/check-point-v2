import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/core/tenant/tenant_storage.dart';
import 'package:check_point_v2/features/tenant/data/models/tenant_model.dart';

class CurrentTenantBadgeWidget extends StatefulWidget {
  const CurrentTenantBadgeWidget({this.onTenantChanged, super.key});

  final VoidCallback? onTenantChanged;

  @override
  State<CurrentTenantBadgeWidget> createState() =>
      _CurrentTenantBadgeWidgetState();
}

class _CurrentTenantBadgeWidgetState extends State<CurrentTenantBadgeWidget> {
  TenantModel? _currentTenant;

  @override
  void initState() {
    super.initState();
    _loadTenant();
  }

  Future<void> _loadTenant() async {
    final tenant = await sl<TenantStorage>().readTenant();
    if (mounted) {
      setState(() => _currentTenant = tenant);
    }
  }

  Future<void> _onTapChange() async {
    await Navigator.of(context).pushNamed(AppRoutes.tenantLookup);
    await _loadTenant();
    widget.onTenantChanged?.call();
  }

  @override
  Widget build(BuildContext context) {
    final displayName = _currentTenant?.companyName?.isNotEmpty == true
        ? _currentTenant!.companyName!
        : (_currentTenant?.tenantCode?.isNotEmpty == true
            ? _currentTenant!.tenantCode!
            : AppConfig.tenantCompanyName);

    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: _onTapChange,
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: 10.w,
            vertical: 6.h,
          ),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: AppColors.border),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.business_rounded,
                size: 15.r,
                color: AppColors.brandPrimary,
              ),
              wSpace(6),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 160.w),
                child: Text(
                  displayName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.font12Medium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              wSpace(4),
              Icon(
                Icons.swap_horiz_rounded,
                size: 16.r,
                color: AppColors.placeholder,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
