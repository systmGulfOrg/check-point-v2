import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/connectivity/connectivity_cubit.dart';
import 'package:check_point_v2/core/connectivity/connectivity_state.dart';

class OfflineBannerWidget extends StatelessWidget {
  const OfflineBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityCubit, ConnectivityState>(
      builder: (context, state) {
        final isOffline = !state.isOnline;
        return AnimatedCrossFade(
          duration: const Duration(milliseconds: 250),
          crossFadeState:
              isOffline ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          firstChild: SafeArea(
            bottom: false,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: const BoxDecoration(
                color: Color(0xFFD97706), // warm amber-600
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.wifi_off_rounded,
                    color: Colors.white,
                    size: 16.sp,
                  ),
                  SizedBox(width: 8.w),
                  Flexible(
                    child: Text(
                      '${'offline.banner'.tr()}${state.pendingCount > 0 ? 'offline.pendingCount'.tr(args: [state.pendingCount.toString()]) : ''}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          secondChild: const SizedBox.shrink(),
        );
      },
    );
  }
}
