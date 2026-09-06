import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../data/models/admin_attendance_model.dart';
import '../../data/repos/admin_attendance_repo.dart';
import 'admin_attendance_state.dart';

enum AdminAttendanceDateFilter {
  today,
  last30Days,
  last90Days,
  last180Days,
  custom,
  all,
}

class AdminAttendanceCubit extends Cubit<AdminAttendanceState> {
  AdminAttendanceCubit({required this.attendanceRepo})
    : super(const AdminAttendanceState.initial());

  final AdminAttendanceRepo attendanceRepo;

  List<AdminAttendanceModel> _allRecords = [];
  AdminAttendanceDateFilter _selectedDateFilter =
      AdminAttendanceDateFilter.today;
  DateTime? _customStartDate;
  DateTime? _customEndDate;
  String _searchQuery = '';

  AdminAttendanceDateFilter get selectedDateFilter => _selectedDateFilter;
  DateTime? get customStartDate => _customStartDate;
  DateTime? get customEndDate => _customEndDate;
  String get searchQuery => _searchQuery;

  Future<void> loadAttendance() async {
    emit(const AdminAttendanceState.loading());
    final result = await attendanceRepo.getAdminAttendance();
    switch (result) {
      case Success(:final data):
        _allRecords = data;
        _emitFiltered();
      case Failure(:final failure):
        emit(AdminAttendanceState.error(failure.messageKey));
    }
  }

  Future<void> setDateFilter(
    AdminAttendanceDateFilter filter, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    _selectedDateFilter = filter;
    _customStartDate = startDate;
    _customEndDate = endDate;
    emit(const AdminAttendanceState.loading());
    await Future<void>.delayed(const Duration(milliseconds: 150));
    _emitFiltered();
  }

  void search(String query) {
    _searchQuery = query.trim().toLowerCase();
    _emitFiltered();
  }

  void _emitFiltered() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final filtered = _allRecords.where((record) {
      // 1. Search Query Filter
      if (_searchQuery.isNotEmpty) {
        final name = (record.employeeName ?? '').toLowerCase();
        final area = (record.area ?? '').toLowerCase();
        final date = (record.attendanceDate ?? '').toLowerCase();
        if (!name.contains(_searchQuery) &&
            !area.contains(_searchQuery) &&
            !date.contains(_searchQuery)) {
          return false;
        }
      }

      // 2. Date Filter
      final recordDate = _parseDate(record.attendanceDate);
      if (recordDate == null) {
        return _selectedDateFilter == AdminAttendanceDateFilter.all;
      }

      final recordDay = DateTime(
        recordDate.year,
        recordDate.month,
        recordDate.day,
      );

      switch (_selectedDateFilter) {
        case AdminAttendanceDateFilter.today:
          return recordDay.isAtSameMomentAs(today);
        case AdminAttendanceDateFilter.last30Days:
          final start = today.subtract(const Duration(days: 30));
          return !recordDay.isBefore(start) && !recordDay.isAfter(today);
        case AdminAttendanceDateFilter.last90Days:
          final start = today.subtract(const Duration(days: 90));
          return !recordDay.isBefore(start) && !recordDay.isAfter(today);
        case AdminAttendanceDateFilter.last180Days:
          final start = today.subtract(const Duration(days: 180));
          return !recordDay.isBefore(start) && !recordDay.isAfter(today);
        case AdminAttendanceDateFilter.custom:
          if (_customStartDate == null || _customEndDate == null) return true;
          final start = DateTime(
            _customStartDate!.year,
            _customStartDate!.month,
            _customStartDate!.day,
          );
          final end = DateTime(
            _customEndDate!.year,
            _customEndDate!.month,
            _customEndDate!.day,
          );
          return !recordDay.isBefore(start) && !recordDay.isAfter(end);
        case AdminAttendanceDateFilter.all:
          return true;
      }
    }).toList();

    emit(AdminAttendanceState.success(filtered));
  }

  DateTime? _parseDate(String? raw) {
    if (raw == null || raw.trim().isEmpty) return null;
    try {
      return DateTime.parse(raw);
    } catch (_) {
      try {
        final parts = raw.split('-');
        if (parts.length >= 3) {
          final year = int.parse(parts[0]);
          final month = int.parse(parts[1]);
          final dayStr = parts[2].split('T').first.split(' ').first;
          final day = int.parse(dayStr);
          return DateTime(year, month, day);
        }
      } catch (_) {}
      return null;
    }
  }

  Future<bool> deleteAttendance(int id) async {
    emit(const AdminAttendanceState.loading());
    final result = await attendanceRepo.deleteAttendance(id);
    switch (result) {
      case Success():
        await loadAttendance();
        emit(
          const AdminAttendanceState.actionSuccess(
            'Attendance record deleted successfully',
          ),
        );
        return true;
      case Failure(:final failure):
        emit(AdminAttendanceState.error(failure.messageKey));
        return false;
      default:
        return false;
    }
  }
}
