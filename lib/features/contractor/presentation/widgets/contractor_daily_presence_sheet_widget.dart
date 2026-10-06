import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/app/app_spaces.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';
import 'package:check_point_v2/core/widgets/custom_button.dart';
import 'package:check_point_v2/core/widgets/custom_text_form_field.dart';
import 'package:check_point_v2/features/contractor/data/models/site_boundary_model.dart';
import '../cubit/contractor_cubit.dart';

class ContractorDailyPresenceSheetWidget extends StatefulWidget {
  const ContractorDailyPresenceSheetWidget({
    required this.contractorId,
    required this.contractorName,
    required this.sites,
    super.key,
  });

  final String contractorId;
  final String contractorName;
  final List<SiteBoundaryModel> sites;

  @override
  State<ContractorDailyPresenceSheetWidget> createState() =>
      _ContractorDailyPresenceSheetWidgetState();
}

class _ContractorDailyPresenceSheetWidgetState
    extends State<ContractorDailyPresenceSheetWidget> {
  late final TextEditingController _notesController;
  String? _selectedSiteId;
  final String _status = 'Present';
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController();
    if (widget.sites.isNotEmpty) {
      _selectedSiteId = widget.sites.first.siteId;
    }
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _submitPresence() async {
    if (_selectedSiteId == null) return;
    setState(() => _isSubmitting = true);

    final cubit = context.read<ContractorCubit>();
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    final success = await cubit.recordSamcoContractorAttendance(
      contractorId: widget.contractorId,
      siteId: _selectedSiteId!,
      date: today,
      status: _status,
      notes: _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),
    );

    if (!mounted) return;
    setState(() => _isSubmitting = false);

    if (success) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم تسجيل حضور المقاول اليومي بنجاح'),
          backgroundColor: AppColors.success,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 18.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'إثبات حضور المقاول بالموقع',
                  style: AppTextStyles.font16Bold.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          hSpace(6),
          Text(
            widget.contractorName,
            style: AppTextStyles.font13Medium.copyWith(
              color: AppColors.brandPrimary,
            ),
          ),
          hSpace(14),
          DropdownButtonFormField<String>(
            isExpanded: true,
            initialValue: _selectedSiteId,
            decoration: InputDecoration(
              labelText: 'موقع العمل',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            items: widget.sites
                .map(
                  (s) => DropdownMenuItem<String>(
                    value: s.siteId,
                    child: Text(s.siteName),
                  ),
                )
                .toList(),
            onChanged: (val) => setState(() => _selectedSiteId = val),
          ),
          hSpace(12),
          CustomTextFormField(
            controller: _notesController,
            hintText: 'ملاحظات يومية (اختياري)...',
            maxLines: 2,
          ),
          hSpace(20),
          CustomButton(
            text: 'تسجيل الحضور اليومي للمقاول',
            isLoading: _isSubmitting,
            enabled: _selectedSiteId != null,
            onTap: _submitPresence,
          ),
        ],
      ),
    );
  }
}
