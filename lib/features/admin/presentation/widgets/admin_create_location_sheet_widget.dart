import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import 'admin_locations_tab_widget.dart';

class AdminCreateLocationSheetWidget extends StatefulWidget {
  const AdminCreateLocationSheetWidget({required this.category, super.key});

  final AdminLocationCategory category;

  @override
  State<AdminCreateLocationSheetWidget> createState() =>
      _AdminCreateLocationSheetWidgetState();
}

class _AdminCreateLocationSheetWidgetState
    extends State<AdminCreateLocationSheetWidget> {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final descriptionController = TextEditingController();
  final searchController = TextEditingController();
  bool isActive = true;

  String get titleKey => switch (widget.category) {
    AdminLocationCategory.branches => 'admin.locations.create.branchTitle',
    AdminLocationCategory.departments => 'Department',
    AdminLocationCategory.sites => 'admin.locations.create.siteTitle',
    AdminLocationCategory.customers => 'admin.locations.create.customerTitle',
  };

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    descriptionController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 16.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    titleKey.tr(context: context),
                    style: AppTextStyles.font18Bold,
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close_rounded, size: 20.r),
                  ),
                ],
              ),
              const Divider(color: AppColors.border),
              hSpace(14),
              Text(
                'admin.locations.create.nameLabel'.tr(context: context),
                style: AppTextStyles.font12Medium,
              ),
              hSpace(8),
              CustomTextFormField(
                controller: nameController,
                hintText: 'admin.locations.create.nameHint'.tr(
                  context: context,
                ),
              ),
              hSpace(16),
              Text(
                'admin.locations.create.addressLabel'.tr(context: context),
                style: AppTextStyles.font12Medium,
              ),
              hSpace(8),
              CustomTextFormField(
                controller: addressController,
                hintText: 'admin.locations.create.addressHint'.tr(
                  context: context,
                ),
              ),
              hSpace(16),
              Text(
                'admin.locations.create.descriptionLabel'.tr(context: context),
                style: AppTextStyles.font12Medium,
              ),
              hSpace(8),
              CustomTextFormField(
                controller: descriptionController,
                hintText: 'admin.locations.create.descriptionHint'.tr(
                  context: context,
                ),
                maxLines: 3,
              ),
              hSpace(16),
              Text(
                'admin.locations.create.geofenceTitle'.tr(context: context),
                style: AppTextStyles.font12Medium,
              ),
              hSpace(4),
              Text(
                'admin.locations.create.geofenceDescription'.tr(
                  context: context,
                ),
                style: AppTextStyles.font12Regular.copyWith(
                  color: AppColors.placeholder,
                ),
              ),
              hSpace(8),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      controller: searchController,
                      hintText: 'admin.locations.create.searchHint'.tr(
                        context: context,
                      ),
                    ),
                  ),
                  vSpace(8),
                  SizedBox(
                    width: 48.w,
                    child: CustomButton(
                      text: 'admin.locations.create.go'.tr(context: context),
                      onTap: () {},
                      backgroundColor: AppColors.pageBackground,
                      textColor: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              hSpace(10),
              Container(
                height: 170.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.softBlueBackground,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.border),
                ),
                child: Center(
                  child: Icon(
                    Icons.map_outlined,
                    color: AppColors.info,
                    size: 42.r,
                  ),
                ),
              ),
              hSpace(16),
              Text(
                'admin.locations.create.statusLabel'.tr(context: context),
                style: AppTextStyles.font12Medium,
              ),
              hSpace(8),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'admin.locations.status.active'.tr(
                        context: context,
                      ),
                      onTap: () => setState(() => isActive = true),
                      backgroundColor: isActive
                          ? AppColors.softGreenBackground
                          : AppColors.pageBackground,
                      textColor: isActive
                          ? AppColors.success
                          : AppColors.textSecondary,
                      height: 40,
                    ),
                  ),
                  vSpace(8),
                  Expanded(
                    child: CustomButton(
                      text: 'admin.locations.status.inactive'.tr(
                        context: context,
                      ),
                      onTap: () => setState(() => isActive = false),
                      backgroundColor: !isActive
                          ? AppColors.softBrandBackground
                          : AppColors.pageBackground,
                      textColor: !isActive
                          ? AppColors.error
                          : AppColors.textSecondary,
                      height: 40,
                    ),
                  ),
                ],
              ),
              hSpace(16),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'admin.locations.create.cancel'.tr(
                        context: context,
                      ),
                      onTap: () => Navigator.pop(context),
                      backgroundColor: AppColors.pageBackground,
                      textColor: AppColors.textPrimary,
                    ),
                  ),
                  vSpace(12),
                  Expanded(
                    child: CustomButton(
                      text: 'admin.locations.create.save'.tr(context: context),
                      onTap: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
