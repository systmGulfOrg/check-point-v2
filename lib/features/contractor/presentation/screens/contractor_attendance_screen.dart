import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';
import 'package:check_point_v2/features/contractor/presentation/widgets/contractor_attendance_tile_widget.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_cubit.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_state.dart';

class ContractorAttendanceScreen extends StatelessWidget {
  const ContractorAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        title: Text(
          'contractor.attendance.title'.tr(),
          style: AppTextStyles.font16Bold.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        backgroundColor: AppColors.cardBackground,
        elevation: 0,
      ),
      body: BlocBuilder<ContractorCubit, ContractorState>(
        builder: (context, state) {
          final attendance =
              state.mapOrNull(success: (value) => value.attendanceLogs) ??
              const [];
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            itemCount: attendance.length,
            itemBuilder: (context, index) =>
                ContractorAttendanceTileWidget(attendance: attendance[index]),
          );
        },
      ),
    );
  }
}
