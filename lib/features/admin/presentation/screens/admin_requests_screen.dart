import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../widgets/admin_account_requests_bloc_builder_widget.dart';

class AdminRequestsScreen extends StatefulWidget {
  const AdminRequestsScreen({super.key});

  @override
  State<AdminRequestsScreen> createState() => _AdminRequestsScreenState();
}

class _AdminRequestsScreenState extends State<AdminRequestsScreen> {
  final searchController = TextEditingController();
  bool newestFirst = true;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
    child: SingleChildScrollView(
      padding: EdgeInsetsDirectional.fromSTEB(16.w, 18.h, 16.w, 28.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'admin.requests.title'.tr(context: context),
                      style: AppTextStyles.font20Bold,
                    ),
                    hSpace(4),
                    Text(
                      'admin.requests.subtitle'.tr(context: context),
                      style: AppTextStyles.font12Regular,
                    ),
                  ],
                ),
              ),
              vSpace(8),
              Image.asset(AppAssets.logo, height: 34.h),
            ],
          ),
          hSpace(20),
          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  controller: searchController,
                  hintText: 'admin.requests.searchHint'.tr(context: context),
                  prefixIcon: Icon(Icons.search_rounded, size: 20.r),
                  onChanged: (_) => setState(() {}),
                ),
              ),
              vSpace(10),
              InkWell(
                onTap: () => setState(() => newestFirst = !newestFirst),
                borderRadius: BorderRadius.circular(14.r),
                child: Container(
                  width: 48.r,
                  height: 48.r,
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Icon(
                    newestFirst
                        ? Icons.arrow_downward_rounded
                        : Icons.arrow_upward_rounded,
                    color: AppColors.brandInk,
                    size: 20.r,
                  ),
                ),
              ),
            ],
          ),
          hSpace(18),
          AdminAccountRequestsBlocBuilderWidget(
            onView: (_) => context.pushNamed(AppRoutes.adminRequestDetails),
          ),
        ],
      ),
    ),
  );
}
