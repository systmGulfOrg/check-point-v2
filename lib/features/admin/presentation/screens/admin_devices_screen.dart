import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../../../../core/widgets/custom_dialog_widget.dart';
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
        title: isApprove ? 'Approve Transfer' : 'Reject Transfer',
        message: isApprove
            ? 'Are you sure you want to approve this device transfer?'
            : 'Are you sure you want to reject this device transfer?',
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
        confirmLabel: isApprove ? 'Approve' : 'Reject',
        confirmButtonColor: isApprove ? AppColors.success : AppColors.error,
        cancelLabel: 'Cancel',
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
        title: Text('admin.devices.pendingTitle'.tr(context: context), style: AppTextStyles.font18Bold),
      ),
      body: SafeArea(
        child: BlocConsumer<AdminPendingDevicesCubit, AdminPendingDevicesState>(
          listener: (context, state) {
            state.maybeMap(
              error: (state) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              },
              orElse: () {},
            );
          },
          builder: (context, state) {
            return state.map(
              initial: (_) => const Center(
                child: CircularProgressIndicator(color: AppColors.brandPrimary),
              ),
              loading: (_) => const Center(
                child: CircularProgressIndicator(color: AppColors.brandPrimary),
              ),
              error: (state) => Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: AppColors.error),
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
                                CircleAvatar(
                                  radius: 20.r,
                                  backgroundColor:
                                      AppColors.softBrandBackground,
                                  child: Text(
                                    dev.employeeName?.isNotEmpty == true
                                        ? dev.employeeName![0].toUpperCase()
                                        : '?',
                                    style: AppTextStyles.font16Bold.copyWith(
                                      color: AppColors.brandPrimary,
                                    ),
                                  ),
                                ),
                                wSpace(12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        dev.employeeName ?? 'Unknown Employee',
                                        style: AppTextStyles.font16Bold,
                                      ),
                                      if (dev.deviceModel != null)
                                        Text(
                                          'Model: ${dev.deviceModel}',
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
                                    'Device ID: ${dev.deviceId}',
                                    style: AppTextStyles.font12Regular,
                                  ),
                                  if (dev.osVersion != null)
                                    Text(
                                      'OS: ${dev.osVersion}',
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
                                    child: const Text('Reject'),
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
                                    child: const Text(
                                      'Approve',
                                      style: TextStyle(color: AppColors.white),
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
