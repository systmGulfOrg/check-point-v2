import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../widgets/employee_header_widget.dart';
import '../widgets/employee_plan_data.dart';
import '../widgets/employee_plans_section_widget.dart';
import '../widgets/employee_stats_row_widget.dart';
import '../widgets/employee_task_data.dart';
import '../widgets/employee_tasks_section_widget.dart';
import '../widgets/employee_today_card_widget.dart';

class EmployeeHomeScreen extends StatefulWidget {
  const EmployeeHomeScreen({
    this.onViewAllTasks,
    this.onViewAllPlans,
    super.key,
  });

  final VoidCallback? onViewAllTasks;
  final VoidCallback? onViewAllPlans;

  @override
  State<EmployeeHomeScreen> createState() => _EmployeeHomeScreenState();
}

class _EmployeeHomeScreenState extends State<EmployeeHomeScreen> {
  bool _isCheckedIn = false;
  bool _hasCheckedOut = true;
  String _checkInTime = '08:02';
  String _checkOutTime = '16:06';
  String? _workedHours = '8.07h worked';

  static const _tasks = <EmployeeTaskData>[
    EmployeeTaskData(
      id: '1',
      title: 'Onboard New Contractors',
      dueDate: 'Due 2026-08-30',
      status: 'Overdue',
      priority: 'Urgent',
      description: 'Process onboarding documents for 3 new contractors.',
      progressPercentage: 20,
      assignees: ['JM', 'FA'],
    ),
    EmployeeTaskData(
      id: '2',
      title: 'Complete Q3 Attendance Report',
      dueDate: 'Due 2026-09-05',
      status: 'In Progress',
      priority: 'High',
      description: 'Compile attendance and performance metrics for Q3 2026.',
      progressPercentage: 45,
      assignees: ['JM'],
    ),
  ];

  static const _plans = <EmployeePlanData>[
    EmployeePlanData(
      id: '1',
      title: 'Emergency Response Drill',
      dateTime: '2026-09-15 09:00',
      planType: 'Mission',
      description: 'Annual emergency response training exercise.',
      status: 'planned',
      assignees: ['JM', 'PN', 'FA'],
    ),
    EmployeePlanData(
      id: '2',
      title: 'Al Futtaim Site Inspection',
      dateTime: '2026-09-10 10:00',
      planType: 'Customer Visit',
      locationName: 'Al Futtaim Group',
      description: 'Monthly review meeting with Al Futtaim...',
      status: 'planned',
      assignees: ['JM', 'SJ'],
    ),
  ];

  void _toggleCheckInOut() {
    setState(() {
      if (_isCheckedIn) {
        _isCheckedIn = false;
        _hasCheckedOut = true;
        _checkOutTime = '16:06';
        _workedHours = '8.07h worked';
      } else {
        _isCheckedIn = true;
        _hasCheckedOut = false;
        _checkInTime = '08:02';
        _checkOutTime = '—';
        _workedHours = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EmployeeHeaderWidget(
                titleKey: 'employee.home.title',
                userName: 'James',
                dateText: AppDateFormatter.formatFullDate(DateTime.now()),
                notificationCount: 1,
              ),
              hSpace(20),
              EmployeeTodayCardWidget(
                policyText: 'Policy B — 08:00–16:00 · 08:00 – 16:00',
                isOnTime: true,
                checkInTime: _checkInTime,
                checkOutTime: _checkOutTime,
                isCheckedIn: _isCheckedIn,
                hasCheckedOut: _hasCheckedOut,
                workedHours: _workedHours,
                onToggleCheckInOut: _toggleCheckInOut,
              ),
              hSpace(20),
              const EmployeeStatsRowWidget(
                activeTasksCount: 2,
                upcomingPlansCount: 2,
                pendingLeavesCount: 1,
              ),
              hSpace(20),
              EmployeeTasksSectionWidget(
                tasks: _tasks,
                onViewAllTap: widget.onViewAllTasks ?? () {},
              ),
              hSpace(20),
              EmployeePlansSectionWidget(
                plans: _plans,
                onViewAllTap: widget.onViewAllPlans ?? () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
