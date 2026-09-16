import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../data/models/leave_request_body.dart';
import '../cubit/leaves_cubit.dart';
import '../cubit/leaves_state.dart';

class RequestLeaveScreen extends StatefulWidget {
  const RequestLeaveScreen({super.key});

  @override
  State<RequestLeaveScreen> createState() => _RequestLeaveScreenState();
}

class _RequestLeaveScreenState extends State<RequestLeaveScreen> {
  final _reasonController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  String? _selectedLeaveTypeId;

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_startDate != null &&
        _endDate != null &&
        _selectedLeaveTypeId != null) {
      context.read<LeavesCubit>().submitLeave(
        LeaveRequestBody(
          leaveTypeId: _selectedLeaveTypeId!,
          startDate: _startDate!,
          endDate: _endDate!,
          reason: _reasonController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('leaves.request.title'.tr())),
      body: BlocConsumer<LeavesCubit, LeavesState>(
        listener: (context, state) {
          state.whenOrNull(
            submitSuccess: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('leaves.request.success'.tr())),
              );
              Navigator.pop(context);
            },
            error: (msg) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(msg)));
            },
          );
        },
        builder: (context, state) {
          final isSubmitting = state.maybeWhen(
            submitting: () => true,
            orElse: () => false,
          );

          final types = state.maybeWhen(success: (_, t, __) => t, orElse: () => []);

          return Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<String>(
                  value: _selectedLeaveTypeId,
                  items: types
                      .map<DropdownMenuItem<String>>(
                        (t) => DropdownMenuItem<String>(
                          value: t.id,
                          child: Text(t.typeName),
                        ),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => _selectedLeaveTypeId = v),
                  decoration: InputDecoration(
                    labelText: 'leaves.request.type'.tr(),
                  ),
                ),
                SizedBox(height: 16.h),
                TextField(
                  controller: _reasonController,
                  decoration: InputDecoration(
                    labelText: 'leaves.request.reason'.tr(),
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 24.h),
                ElevatedButton(
                  onPressed: isSubmitting ? null : _submit,
                  child: isSubmitting
                      ? const CircularProgressIndicator()
                      : Text('leaves.request.submit'.tr()),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
