import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AdminLocationSearchBarWidget extends StatelessWidget {
  const AdminLocationSearchBarWidget({
    required this.controller,
    required this.isSearching,
    required this.isLocating,
    required this.onSearchChanged,
    required this.onGoPressed,
    required this.onPasteLinkPressed,
    required this.onCurrentLocationPressed,
    super.key,
  });

  final TextEditingController controller;
  final bool isSearching;
  final bool isLocating;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onGoPressed;
  final VoidCallback onPasteLinkPressed;
  final VoidCallback onCurrentLocationPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextFormField(
            controller: controller,
            hintText: 'admin.locations.create.searchHint'.tr(context: context),
            onChanged: onSearchChanged,
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isSearching)
                  Padding(
                    padding: EdgeInsets.all(10.r),
                    child: SizedBox(
                      width: 16.r,
                      height: 16.r,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.brandPrimary,
                      ),
                    ),
                  )
                else ...[
                  IconButton(
                    icon: Icon(
                      Icons.link_rounded,
                      size: 20.r,
                      color: AppColors.textSecondary,
                    ),
                    tooltip: 'admin.locations.create.pasteLink'.tr(
                      context: context,
                    ),
                    onPressed: onPasteLinkPressed,
                  ),
                  IconButton(
                    icon: isLocating
                        ? SizedBox(
                            width: 16.r,
                            height: 16.r,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.brandPrimary,
                            ),
                          )
                        : Icon(
                            Icons.my_location_rounded,
                            size: 20.r,
                            color: AppColors.brandPrimary,
                          ),
                    tooltip: 'admin.locations.create.currentLocation'.tr(
                      context: context,
                    ),
                    onPressed: isLocating ? null : onCurrentLocationPressed,
                  ),
                ],
              ],
            ),
          ),
        ),
        vSpace(8),
        SizedBox(
          width: 52.w,
          height: 48.h,
          child: CustomButton(
            text: 'admin.locations.create.go'.tr(context: context),
            onTap: onGoPressed,
            backgroundColor: AppColors.pageBackground,
            textColor: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
