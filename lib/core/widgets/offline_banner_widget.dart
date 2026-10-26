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

        return AnimatedSlide(
          duration: const Duration(milliseconds: 320),
          curve: Curves.easeOutCubic,
          offset: isOffline ? Offset.zero : const Offset(0, -1.3),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 260),
            opacity: isOffline ? 1.0 : 0.0,
            child: isOffline
                ? Material(
                    type: MaterialType.transparency,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SafeArea(
                        bottom: false,
                        child: Container(
                          margin: EdgeInsets.only(
                            top: 8.h,
                            left: 16.w,
                            right: 16.w,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            // Sleek dark capsule matching iOS Dynamic Island aesthetics
                            color: const Color(0xF2111827),
                            borderRadius: BorderRadius.circular(24.r),
                            border: Border.all(
                              color: const Color(0xFFF59E0B).withValues(alpha: 0.4),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.28),
                                blurRadius: 16,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: EdgeInsets.all(6.r),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF59E0B).withValues(alpha: 0.18),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.wifi_off_rounded,
                                  color: const Color(0xFFFBBF24),
                                  size: 15.sp,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Flexible(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'offline.bannerTitle'.tr(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w700,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    SizedBox(height: 1.h),
                                    Text(
                                      'offline.bannerSubtitle'.tr(),
                                      style: TextStyle(
                                        color: const Color(0xFF94A3B8),
                                        fontSize: 10.5.sp,
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.none,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              if (state.pendingCount > 0) ...[
                                SizedBox(width: 8.w),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 3.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF59E0B),
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Text(
                                    '${state.pendingCount} ${'offline.pending'.tr()}',
                                    style: TextStyle(
                                      color: const Color(0xFF1E293B),
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w800,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}
