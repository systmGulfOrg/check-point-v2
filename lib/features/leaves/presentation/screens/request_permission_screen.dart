import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../data/models/short_leave_request_body.dart';
import '../../data/repos/leaves_repo_impl.dart';
import '../../../../core/di/service_locator.dart';

// Standalone StatefulWidget since the cubit might only handle leaves or we can extend it
class RequestPermissionScreen extends StatefulWidget {
  const RequestPermissionScreen({super.key});

  @override
  State<RequestPermissionScreen> createState() => _RequestPermissionScreenState();
}

class _RequestPermissionScreenState extends State<RequestPermissionScreen> {
  final _reasonController = TextEditingController();
  final _repo = sl<LeavesRepoImpl>();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _isSubmitting = true);
    
    final body = ShortLeaveRequestBody(
      date: DateTime.now(),
      startTime: "09:00",
      endTime: "11:00",
      reason: _reasonController.text,
    );
    
    // In a real app we add a method to repo for submitShortLeave, let's assume it exists in api
    try {
      await _repo.api.submitShortLeaveRequest(body);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('permissions.request.success'.tr())),
        );
        Navigator.pop(context);
      }
    } catch(e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('permissions.request.title'.tr())),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _reasonController,
              decoration: InputDecoration(labelText: 'leaves.request.reason'.tr()),
              maxLines: 3,
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: _isSubmitting ? null : _submit,
              child: _isSubmitting 
                ? const CircularProgressIndicator()
                : Text('leaves.request.submit'.tr()),
            )
          ],
        ),
      ),
    );
  }
}
