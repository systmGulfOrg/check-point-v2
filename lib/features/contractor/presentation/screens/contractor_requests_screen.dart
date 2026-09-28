import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';
import 'package:check_point_v2/features/contractor/presentation/widgets/contractor_correction_card_widget.dart';
import 'package:check_point_v2/features/contractor/presentation/widgets/contractor_new_request_sheet_widget.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_cubit.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_state.dart';

class ContractorRequestsScreen extends StatefulWidget {
  const ContractorRequestsScreen({super.key});

  @override
  State<ContractorRequestsScreen> createState() =>
      _ContractorRequestsScreenState();
}

class _ContractorRequestsScreenState extends State<ContractorRequestsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        title: Text(
          'contractor.requests.title'.tr(),
          style: AppTextStyles.font16Bold.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        backgroundColor: AppColors.cardBackground,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add_circle_outline_rounded,
              color: AppColors.brandPrimary,
            ),
            onPressed: () => _openNewRequestSheet(context),
          ),
        ],
      ),
      body: BlocBuilder<ContractorCubit, ContractorState>(
        builder: (context, state) {
          final requests =
              state.mapOrNull(success: (value) => value.corrections) ??
              const [];
          return requests.isEmpty
              ? Center(child: Text('no_data'.tr()))
              : ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 14.h,
                  ),
                  itemCount: requests.length,
                  itemBuilder: (context, index) {
                    final item = requests[index];
                    return ContractorCorrectionCardWidget(correction: item);
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.brandPrimary,
        onPressed: () => _openNewRequestSheet(context),
        icon: const Icon(Icons.add_rounded, color: AppColors.white),
        label: Text(
          'contractor.requests.newRequest'.tr(),
          style: AppTextStyles.font14Bold.copyWith(color: AppColors.white),
        ),
      ),
    );
  }

  void _openNewRequestSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => BlocBuilder<ContractorCubit, ContractorState>(
        builder: (context, state) {
          final attendance =
              state.mapOrNull(success: (value) => value.attendanceLogs) ??
              const [];
          return ContractorNewRequestSheetWidget(
            attendance: attendance,
            onSubmit: (body) async {
              final succeeded = await context
                  .read<ContractorCubit>()
                  .submitCorrectionRequest(body);
              if (succeeded && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('contractor.requests.pending'.tr()),
                    backgroundColor: AppColors.info,
                  ),
                );
              }
              return succeeded;
            },
          );
        },
      ),
    );
  }
}
