import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:check_point_v2/core/core.dart';
import '../cubit/overtime_cubit.dart';

class OvertimeRequestFormWidget extends StatefulWidget {
  const OvertimeRequestFormWidget({required this.cubit, super.key});
  final OvertimeCubit cubit;
  @override
  State<OvertimeRequestFormWidget> createState() =>
      _OvertimeRequestFormWidgetState();
}

class _OvertimeRequestFormWidgetState extends State<OvertimeRequestFormWidget> {
  late final TextEditingController reasonController;
  DateTime date = DateTime.now();
  TimeOfDay? start;
  TimeOfDay? end;
  bool submitting = false;

  @override
  void initState() {
    super.initState();
    reasonController = TextEditingController();
  }

  @override
  void dispose() {
    reasonController.dispose();
    super.dispose();
  }

  Future<void> submit() async {
    if (start == null || end == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('overtime.selectTimes'.tr(context: context))),
      );
      return;
    }
    final startMinutes = start!.hour * 60 + start!.minute;
    final endMinutes = end!.hour * 60 + end!.minute;
    if (endMinutes <= startMinutes) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('overtime.invalidTimeRange'.tr(context: context)),
        ),
      );
      return;
    }
    setState(() => submitting = true);
    final ok = await widget.cubit.create(
      requestDate: DateFormat('yyyy-MM-dd', 'en_US').format(date),
      startTime:
          '${start!.hour.toString().padLeft(2, '0')}:${start!.minute.toString().padLeft(2, '0')}',
      endTime:
          '${end!.hour.toString().padLeft(2, '0')}:${end!.minute.toString().padLeft(2, '0')}',
      reason: reasonController.text.trim().isEmpty
          ? null
          : reasonController.text.trim(),
    );
    if (!mounted) return;
    setState(() => submitting = false);
    if (ok) {
      reasonController.clear();
      setState(() {
        start = null;
        end = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('overtime.requestSent'.tr(context: context))),
      );
    }
  }

  @override
  Widget build(BuildContext context) => AppCardContainerWidget(
    backgroundColor: AppColors.softOrangeLightBackground,
    child: Padding(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38.w,
                height: 38.w,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.more_time_rounded,
                  color: AppColors.brandPrimary,
                  size: 22.r,
                ),
              ),
              wSpace(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'overtime.newRequest'.tr(context: context),
                      style: AppTextStyles.font16Bold,
                    ),
                    hSpace(2),
                    Text(
                      'overtime.newRequestHint'.tr(context: context),
                      style: AppTextStyles.font11Regular,
                    ),
                  ],
                ),
              ),
            ],
          ),
          hSpace(12),
          CustomTextFormField(
            hintText: 'overtime.date'.tr(context: context),
            readOnly: true,
            prefixIcon: const Icon(Icons.calendar_today_outlined),
            initialValue: DateFormat('yyyy-MM-dd', 'en_US').format(date),
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 90)),
                initialDate: date,
              );
              if (picked != null) setState(() => date = picked);
            },
          ),
          hSpace(10),
          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  hintText: start == null
                      ? 'overtime.from'.tr(context: context)
                      : start!.format(context),
                  readOnly: true,
                  prefixIcon: const Icon(Icons.access_time),
                  onTap: () async {
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: start ?? TimeOfDay.now(),
                    );
                    if (picked != null) setState(() => start = picked);
                  },
                ),
              ),
              wSpace(10),
              Expanded(
                child: CustomTextFormField(
                  hintText: end == null
                      ? 'overtime.to'.tr(context: context)
                      : end!.format(context),
                  readOnly: true,
                  prefixIcon: const Icon(Icons.access_time),
                  onTap: () async {
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: end ?? TimeOfDay.now(),
                    );
                    if (picked != null) setState(() => end = picked);
                  },
                ),
              ),
            ],
          ),
          hSpace(10),
          CustomTextFormField(
            hintText: 'overtime.reason'.tr(context: context),
            controller: reasonController,
            maxLines: 3,
          ),
          hSpace(12),
          CustomButton(
            text: 'overtime.submit'.tr(context: context),
            onTap: submit,
            isLoading: submitting,
            icon: Icons.send_rounded,
          ),
        ],
      ),
    ),
  );
}
