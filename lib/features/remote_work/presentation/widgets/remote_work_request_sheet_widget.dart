import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/remote_work_policy_model.dart';

class RemoteWorkRequestSheetWidget extends StatefulWidget {
  const RemoteWorkRequestSheetWidget({
    required this.policies,
    required this.onSubmit,
    super.key,
  });

  final List<RemoteWorkPolicyModel> policies;
  final Future<bool> Function({
    required String requestDate,
    required String targetWorkSystem,
    String? policyId,
    String? reason,
  })
  onSubmit;

  @override
  State<RemoteWorkRequestSheetWidget> createState() =>
      _RemoteWorkRequestSheetWidgetState();
}

class _RemoteWorkRequestSheetWidgetState
    extends State<RemoteWorkRequestSheetWidget> {
  late DateTime selectedDate;
  String targetWorkSystem = 'remote';
  String? selectedPolicyId;
  late final TextEditingController dateController;
  late final TextEditingController reasonController;
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now().add(const Duration(days: 1));
    dateController = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(selectedDate),
    );
    reasonController = TextEditingController();
  }

  @override
  void dispose() {
    dateController.dispose();
    reasonController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );
    if (date != null && mounted) {
      setState(() {
        selectedDate = date;
        dateController.text = DateFormat('dd/MM/yyyy').format(date);
      });
    }
  }

  Future<void> _submit() async {
    setState(() => isSubmitting = true);
    final success = await widget.onSubmit(
      requestDate: DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
      ).toIso8601String(),
      targetWorkSystem: targetWorkSystem,
      policyId: selectedPolicyId,
      reason: reasonController.text.trim(),
    );
    if (mounted) {
      setState(() => isSubmitting = false);
      if (success) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Padding(
      padding: EdgeInsets.fromLTRB(
        20.w,
        18.h,
        20.w,
        MediaQuery.of(context).viewInsets.bottom + 20.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'remoteWork.requestTitle'.tr(context: context),
                style: AppTextStyles.font18Bold,
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.close_rounded, size: 20.r),
              ),
            ],
          ),
          Text(
            'remoteWork.requestTarget'.tr(context: context),
            style: AppTextStyles.font13SemiBold,
          ),
          SegmentedButton<String>(
            segments: [
              ButtonSegment(
                value: 'remote',
                label: Text('remoteWork.remoteTab'.tr(context: context)),
                icon: const Icon(Icons.home_work_outlined),
              ),
              ButtonSegment(
                value: 'onsite',
                label: Text('remoteWork.onsiteTab'.tr(context: context)),
                icon: const Icon(Icons.business_outlined),
              ),
            ],
            selected: {targetWorkSystem},
            onSelectionChanged: (value) => setState(() {
              targetWorkSystem = value.first;
              selectedPolicyId = null;
            }),
          ),
          hSpace(12),
          CustomTextFormField(
            controller: dateController,
            readOnly: true,
            hintText: 'remoteWork.date'.tr(context: context),
            onTap: _selectDate,
            suffixIcon: const Icon(Icons.calendar_today_outlined),
          ),
          hSpace(12),
          CustomTextFormField(
            controller: reasonController,
            hintText: 'remoteWork.reason'.tr(context: context),
            maxLines: 3,
          ),
          hSpace(16),
          CustomButton(
            text: 'remoteWork.submit'.tr(context: context),
            isLoading: isSubmitting,
            onTap: _submit,
          ),
        ],
      ),
    ),
  );
}
