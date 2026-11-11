import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/verification/pending_verification_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/verification/pending_verification_state.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/pending_attendance_verification_list_widget.dart';

class PendingAttendanceVerificationScreen extends StatefulWidget {
  const PendingAttendanceVerificationScreen({super.key});

  @override
  State<PendingAttendanceVerificationScreen> createState() =>
      _PendingAttendanceVerificationScreenState();
}

class _PendingAttendanceVerificationScreenState
    extends State<PendingAttendanceVerificationScreen> {
  final TextEditingController _reasonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<PendingVerificationCubit>().loadPendingVerifications();
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  void _showRejectDialog(String itemId) {
    _reasonController.clear();
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('offline.reject'.tr(), style: AppTextStyles.font18Bold),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'offline.rejectReasonHint'.tr(),
              style: AppTextStyles.font14Regular,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _reasonController,
              maxLines: 2,
              decoration: InputDecoration(
                hintText: 'offline.rejectReasonHint'.tr(),
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('core.actions.cancel'.tr()),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              final reason = _reasonController.text.trim();
              Navigator.pop(ctx);
              context.read<PendingVerificationCubit>().reject(
                    itemId,
                    reason: reason.isEmpty ? null : reason,
                  );
            },
            child: Text(
              'offline.reject'.tr(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        title: Text('offline.pendingVerificationTitle'.tr()),
      ),
      body: BlocConsumer<PendingVerificationCubit, PendingVerificationState>(
        listener: (context, state) {
          state.maybeWhen(
            error: (msgKey) =>
                CustomSnackBar.showError(context, message: msgKey.tr()),
            actionSuccess: (msgKey) =>
                CustomSnackBar.showSuccess(context, message: msgKey.tr()),
            orElse: () {},
          );
        },
        builder: (context, state) {
          final cubit = context.read<PendingVerificationCubit>();
          final items = state.maybeWhen(
            loaded: (loadedItems) => loadedItems,
            orElse: () => cubit.currentItems,
          );

          final isLoading = state.maybeWhen(
            loading: () => true,
            orElse: () => false,
          );

          if (isLoading && items.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return PendingAttendanceVerificationListWidget(
            items: items,
            onRefresh: cubit.loadPendingVerifications,
            onApprove: cubit.approve,
            onReject: _showRejectDialog,
          );
        },
      ),
    );
  }
}
