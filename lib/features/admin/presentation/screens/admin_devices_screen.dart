import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/core.dart';
import '../cubit/pending_devices/admin_pending_devices_cubit.dart';
import '../cubit/pending_devices/admin_pending_devices_state.dart';

class AdminDevicesScreen extends StatefulWidget {
  const AdminDevicesScreen({super.key});

  @override
  State<AdminDevicesScreen> createState() => _AdminDevicesScreenState();
}

class _AdminDevicesScreenState extends State<AdminDevicesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AdminPendingDevicesCubit>().loadDevices();
  }

  void _showConfirmDialog(
    BuildContext context,
    String employeeId,
    String deviceId,
    bool isApprove,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => CustomDialogWidget(
        title:
            (isApprove
                    ? 'admin.devices.approveTitle'
                    : 'admin.devices.rejectTitle')
                .tr(context: context),
        message: isApprove
            ? 'admin.devices.approveMessage'.tr(context: context)
            : 'admin.devices.rejectMessage'.tr(context: context),
        icon: isApprove ? Icons.check_circle_outline : Icons.cancel_outlined,
        iconColor: isApprove ? AppColors.success : AppColors.error,
        iconBackgroundColor: isApprove
            ? AppColors.softGreenBackground
            : AppColors.softBrandBackground,
        onConfirm: () {
          Navigator.pop(ctx);
          if (isApprove) {
            context.read<AdminPendingDevicesCubit>().approveDevice(
              employeeId,
              deviceId,
            );
          } else {
            // Call reject API if it exists (for now assuming approveDevice with isActive: false or a reject API is needed)
            // Need to implement rejectDevice in Cubit
            context.read<AdminPendingDevicesCubit>().rejectDevice(
              employeeId,
              deviceId,
            );
          }
        },
        confirmLabel:
            (isApprove ? 'admin.devices.approve' : 'admin.devices.reject').tr(
              context: context,
            ),
        confirmButtonColor: isApprove ? AppColors.success : AppColors.error,
        cancelLabel: 'common.cancel'.tr(context: context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: Text(
          'admin.devices.pendingTitle'.tr(context: context),
          style: AppTextStyles.font18Bold,
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<AdminPendingDevicesCubit, AdminPendingDevicesState>(
          listener: (context, state) {
            state.maybeMap(
              error: (state) {
                CustomSnackBar.show(
                  context,
                  message: state.message.tr(context: context),
                );
              },
              orElse: () {},
            );
          },
          builder: (context, state) {
            final skeletonWidget = Skeletonizer(
              enabled: true,
              child: ListView.builder(
                padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
                itemCount: 3,
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.only(bottom: 12.h),
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(radius: 20.r, child: const Text('O')),
                          wSpace(12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Employee Name Placeholder',
                                style: AppTextStyles.font16Bold,
                              ),
                              Text(
                                'Model: Placeholder Phone',
                                style: AppTextStyles.font12Regular,
                              ),
                            ],
                          ),
                        ],
                      ),
                      hSpace(12),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: AppColors.pageBackground,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          'Device ID: 00000000-0000-0000-0000-000000000000',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );

            return state.map(
              initial: (_) => skeletonWidget,
              loading: (_) => skeletonWidget,
              error: (state) => Center(
                child: Text(
                  state.message,
                  style: AppTextStyles.font14Medium.copyWith(
                    color: AppColors.error,
                  ),
                ),
              ),
              success: (state) {
                final devices = state.devices;
                if (devices.isEmpty) {
                  return Center(
                    child: Text(
                      'admin.devices.noPending'.tr(context: context),
                      style: AppTextStyles.font14Regular,
                    ),
                  );
                }
                return RefreshIndicator(
                  color: AppColors.brandPrimary,
                  onRefresh: context
                      .read<AdminPendingDevicesCubit>()
                      .loadDevices,
                  child: ListView.builder(
                    padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
                    itemCount: devices.length,
                    itemBuilder: (context, index) {
                      final dev = devices[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 12.h),
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: AppColors.border),
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.shadow,
                              blurRadius: 4,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                AppAvatarWidget(
                                  name: dev.employeeName,
                                  subtitle: dev.deviceModel,
                                  radius: 20.r,
                                  enablePreview: true,
                                ),
                                wSpace(12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        dev.employeeName ??
                                            'admin.devices.unknownEmployee'.tr(
                                              context: context,
                                            ),
                                        style: AppTextStyles.font16Bold,
                                      ),
                                      if (dev.deviceModel != null)
                                        Text(
                                          '${'admin.devices.model'.tr(context: context)}: ${dev.deviceModel}',
                                          style: AppTextStyles.font12Regular
                                              .copyWith(
                                                color: AppColors.textSecondary,
                                              ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            hSpace(12),
                            Container(
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                color: AppColors.pageBackground,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${'admin.devices.deviceId'.tr(context: context)}: ${dev.deviceId}',
                                    style: AppTextStyles.font12Regular,
                                  ),
                                  if (dev.osVersion != null)
                                    Text(
                                      '${'admin.devices.os'.tr(context: context)}: ${dev.osVersion}',
                                      style: AppTextStyles.font12Regular,
                                    ),
                                ],
                              ),
                            ),
                            hSpace(12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: AppColors.error,
                                      side: const BorderSide(
                                        color: AppColors.error,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 12.h,
                                      ),
                                    ),
                                    onPressed: () => _showConfirmDialog(
                                      context,
                                      dev.employeeId,
                                      dev.id,
                                      false,
                                    ),
                                    child: Text(
                                      'admin.devices.reject'.tr(
                                        context: context,
                                      ),
                                    ),
                                  ),
                                ),
                                wSpace(12),
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.success,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 12.h,
                                      ),
                                      elevation: 0,
                                    ),
                                    onPressed: () => _showConfirmDialog(
                                      context,
                                      dev.employeeId,
                                      dev.id,
                                      true,
                                    ),
                                    child: Text(
                                      'admin.devices.approve'.tr(
                                        context: context,
                                      ),
                                      style: AppTextStyles.font14Bold.copyWith(
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
