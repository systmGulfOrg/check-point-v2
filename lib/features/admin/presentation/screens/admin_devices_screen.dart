import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        title: Text('Pending Devices', style: AppTextStyles.font16Bold),
        backgroundColor: AppColors.cardBackground,
        elevation: 0,
      ),
      body: BlocConsumer<AdminPendingDevicesCubit, AdminPendingDevicesState>(
        listener: (context, state) {
          state.maybeMap(
            error: (state) {
              final msg = state.message;
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(msg)));
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return state.map(
            initial: (_) => const Center(child: CircularProgressIndicator()),
            loading: (_) => const Center(child: CircularProgressIndicator()),
            error: (state) => Center(
              child: Text(
                state.message,
                style: const TextStyle(color: AppColors.error),
              ),
            ),
            success: (state) {
              final devices = state.devices;
              if (devices.isEmpty) {
                return const Center(
                  child: Text('No pending device transfers.'),
                );
              }
              return ListView.builder(
                padding: EdgeInsets.all(16.w),
                itemCount: devices.length,
                itemBuilder: (context, index) {
                  final dev = devices[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 12.h),
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dev.employeeName ?? 'Unknown Employee',
                          style: AppTextStyles.font16Bold,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Device ID: ${dev.deviceId}',
                          style: AppTextStyles.font14Regular,
                        ),
                        if (dev.deviceModel != null)
                          Text(
                            'Model: ${dev.deviceModel}',
                            style: AppTextStyles.font14Regular,
                          ),
                        if (dev.osVersion != null)
                          Text(
                            'OS: ${dev.osVersion}',
                            style: AppTextStyles.font14Regular,
                          ),
                        SizedBox(height: 12.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.brandPrimary,
                              ),
                              onPressed: () {
                                context
                                    .read<AdminPendingDevicesCubit>()
                                    .approveDevice(
                                      dev.employeeId,
                                      dev.deviceId,
                                    );
                              },
                              child: const Text(
                                'Approve Transfer',
                                style: TextStyle(color: AppColors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
