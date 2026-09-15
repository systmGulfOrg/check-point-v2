import 'package:check_point_v2/features/admin/presentation/cubit/pending_devices/admin_pending_devices_state.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/pending_devices/admin_pending_devices_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AdminTopBarWidget extends StatelessWidget {
  const AdminTopBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(AppAssets.logo, height: 45.h, fit: BoxFit.contain),
        Container(
          width: 40.r,
          height: 40.r,
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.border),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: BlocBuilder<AdminPendingDevicesCubit, AdminPendingDevicesState>(
            builder: (context, state) {
              final pendingCount = state.maybeWhen(
                success: (devices) => devices.length,
                orElse: () => 0,
              );
              
              return Badge(
                isLabelVisible: pendingCount > 0,
                label: Text(pendingCount.toString()),
                backgroundColor: AppColors.error,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.adminPendingDevices);
                  },
                  icon: Icon(
                    Icons.notifications_none_rounded,
                    color: AppColors.brandInk,
                    size: 20.r,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
