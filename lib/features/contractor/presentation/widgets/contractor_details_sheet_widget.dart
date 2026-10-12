import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/app/app_spaces.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_attendance_model.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_company_model.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_worker_model.dart';
import 'package:check_point_v2/features/contractor/data/models/site_boundary_model.dart';
import 'package:check_point_v2/features/contractor/data/repos/contractor_repo.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_cubit.dart';
import 'contractor_batch_attendance_sheet_widget.dart';

class ContractorDetailsSheetWidget extends StatefulWidget {
  const ContractorDetailsSheetWidget({
    required this.contractor,
    required this.workers,
    required this.attendanceLogs,
    this.sites = const [],
    super.key,
  });

  final ContractorCompanyModel contractor;
  final List<ContractorWorkerModel> workers;
  final List<ContractorAttendanceModel> attendanceLogs;
  final List<SiteBoundaryModel> sites;

  @override
  State<ContractorDetailsSheetWidget> createState() =>
      _ContractorDetailsSheetWidgetState();
}

class _ContractorDetailsSheetWidgetState
    extends State<ContractorDetailsSheetWidget> {
  late final TextEditingController _searchController;
  String _query = '';
  List<ContractorWorkerModel> _workers = [];
  List<ContractorAttendanceModel> _attendanceLogs = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _workers = List.from(widget.workers);
    _attendanceLogs = List.from(widget.attendanceLogs);
    if (_workers.isEmpty) {
      _loadData();
    }
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    final repo = sl<ContractorRepo>();
    final today = DateTime.now().toIso8601String().split('T')[0];

    final results = await Future.wait([
      repo.getContractorWorkers(widget.contractor.id),
      repo.getAttendance(from: today, to: today),
    ]);

    if (!mounted) return;

    final workersRes = results[0];
    final attendanceRes = results[1];

    workersRes.when(
      success: (data) {
        if (data is List<ContractorWorkerModel>) {
          setState(() => _workers = data);
        }
      },
      failure: (_) {},
    );

    attendanceRes.when(
      success: (data) {
        if (data is List<ContractorAttendanceModel>) {
          setState(() => _attendanceLogs = data);
        }
      },
      failure: (_) {},
    );

    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _formatTime(String? timeStr) {
    if (timeStr == null || timeStr.isEmpty) return '';
    try {
      final dt = DateTime.parse(timeStr).toLocal();
      return DateFormat('hh:mm a').format(dt);
    } catch (_) {
      return timeStr;
    }
  }

  void _openBatchAttendance() {
    final cubit = context.read<ContractorCubit>();
    Navigator.pop(context);
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: ContractorBatchAttendanceSheetWidget(
          workers: _workers,
          sites: widget.sites,
          contractors: [widget.contractor],
          contractorId: widget.contractor.id,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredWorkers = _workers.where((w) {
      if (_query.isEmpty) return true;
      final q = _query.toLowerCase();
      final name = w.displayName.toLowerCase();
      final code = w.displayCode.toLowerCase();
      return name.contains(q) || code.contains(q);
    }).toList();

    final presentWorkerIds = <String>{};
    for (final log in _attendanceLogs) {
      if (log.status.toLowerCase() == 'present' || log.checkInTime != null) {
        presentWorkerIds.add(log.workerId);
      }
    }

    final presentCount = _workers
        .where((w) => presentWorkerIds.contains(w.id))
        .length;
    final absentCount = _workers.length - presentCount;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.90,
      ),
      padding: EdgeInsets.only(
        top: 12.h,
        left: 16.w,
        right: 16.w,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 44.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          hSpace(12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.contractor.name,
                      style: AppTextStyles.font18Bold.copyWith(
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    hSpace(4),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.softBrandBackground,
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            widget.contractor.code,
                            style: AppTextStyles.font12Bold.copyWith(
                              color: AppColors.brandPrimary,
                            ),
                          ),
                        ),
                        if (widget.contractor.contactPhone != null &&
                            widget.contractor.contactPhone!.isNotEmpty) ...[
                          wSpace(8),
                          Icon(
                            Icons.phone_outlined,
                            size: 14.r,
                            color: AppColors.textSecondary,
                          ),
                          wSpace(4),
                          Text(
                            widget.contractor.contactPhone!,
                            style: AppTextStyles.font12Regular.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.close_rounded,
                  size: 22.r,
                  color: AppColors.textSecondary,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          hSpace(14),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  title: 'إجمالي العمالة',
                  value: '${_workers.length}',
                  color: AppColors.brandPrimary,
                  background: AppColors.softBrandBackground,
                  icon: Icons.people_alt_outlined,
                ),
              ),
              wSpace(8),
              Expanded(
                child: _buildStatCard(
                  title: 'حاضر اليوم',
                  value: '$presentCount',
                  color: AppColors.success,
                  background: AppColors.softGreenBackground,
                  icon: Icons.check_circle_outline_rounded,
                ),
              ),
              wSpace(8),
              Expanded(
                child: _buildStatCard(
                  title: 'غياب اليوم',
                  value: '$absentCount',
                  color: AppColors.warningOrange,
                  background: AppColors.softYellowBackground,
                  icon: Icons.cancel_outlined,
                ),
              ),
            ],
          ),
          hSpace(12),
          if (widget.sites.isNotEmpty) ...[
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.brandPrimary,
                foregroundColor: AppColors.white,
                padding: EdgeInsets.symmetric(vertical: 10.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              onPressed: _openBatchAttendance,
              icon: Icon(Icons.qr_code_scanner_rounded, size: 18.r),
              label: Text(
                'تسجيل حضور عمالة هذا المقاول (${_workers.length})',
                style: AppTextStyles.font12SemiBold.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
            hSpace(12),
          ],
          if (_workers.length > 2) ...[
            TextField(
              controller: _searchController,
              onChanged: (val) => setState(() => _query = val),
              decoration: InputDecoration(
                hintText: 'بحث باسم العامل أو الكود...',
                hintStyle: AppTextStyles.font13Regular.copyWith(
                  color: AppColors.textSecondary,
                ),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  size: 18.r,
                  color: AppColors.textSecondary,
                ),
                filled: true,
                fillColor: AppColors.pageBackground,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 10.h,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            hSpace(12),
          ],
          Text(
            'قائمة العمال (${filteredWorkers.length})',
            style: AppTextStyles.font14Bold.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          hSpace(8),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredWorkers.isEmpty
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 30.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.group_off_rounded,
                                size: 44.r,
                                color: AppColors.border,
                              ),
                              hSpace(8),
                              Text(
                                'لا يوجد عمال مسجلون لهذا المقاول',
                                style: AppTextStyles.font13Medium.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : ListView.separated(
                        itemCount: filteredWorkers.length,
                        separatorBuilder: (_, _) => hSpace(10),
                        itemBuilder: (context, index) {
                          final worker = filteredWorkers[index];
                          final isPresent = presentWorkerIds.contains(worker.id);
                          final log = _attendanceLogs.firstWhere(
                            (l) => l.workerId == worker.id,
                            orElse: () => const ContractorAttendanceModel(
                              id: '',
                              workerId: '',
                              workerName: '',
                              workerCode: '',
                              jobTitle: '',
                              siteName: '',
                              projectName: '',
                              date: '',
                              status: 'Absent',
                            ),
                          );

                          return _buildWorkerTile(
                            worker: worker,
                            isPresent: isPresent,
                            checkInTime: log.checkInTime,
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required Color color,
    required Color background,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Icon(icon, size: 18.r, color: color),
          hSpace(4),
          Text(
            value,
            style: AppTextStyles.font18Bold.copyWith(color: color),
          ),
          hSpace(2),
          Text(
            title,
            style: AppTextStyles.font11Medium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildWorkerTile({
    required ContractorWorkerModel worker,
    required bool isPresent,
    String? checkInTime,
  }) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.pageBackground,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: isPresent
              ? AppColors.success.withValues(alpha: 0.3)
              : AppColors.border,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundColor: isPresent
                ? AppColors.softGreenBackground
                : AppColors.border.withValues(alpha: 0.4),
            child: Text(
              worker.displayName.isNotEmpty ? worker.displayName[0] : 'ع',
              style: AppTextStyles.font14Bold.copyWith(
                color: isPresent ? AppColors.success : AppColors.textSecondary,
              ),
            ),
          ),
          wSpace(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  worker.displayName,
                  style: AppTextStyles.font14Bold.copyWith(
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                hSpace(2),
                Row(
                  children: [
                    Text(
                      worker.displayCode,
                      style: AppTextStyles.font11Medium.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.brandPrimary,
                      ),
                    ),
                    if (worker.siteName != null &&
                        worker.siteName!.isNotEmpty) ...[
                      wSpace(6),
                      Flexible(
                        child: Text(
                          '• ${worker.siteName}',
                          style: AppTextStyles.font11Regular.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          wSpace(8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: isPresent
                  ? AppColors.softGreenBackground
                  : AppColors.border.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isPresent ? 'حاضر' : 'غائب',
                  style: AppTextStyles.font11Medium.copyWith(
                    fontWeight: FontWeight.w700,
                    color:
                        isPresent ? AppColors.success : AppColors.textSecondary,
                  ),
                ),
                if (isPresent && checkInTime != null) ...[
                  hSpace(2),
                  Text(
                    _formatTime(checkInTime),
                    style: AppTextStyles.font10Medium.copyWith(
                      color: AppColors.success,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
