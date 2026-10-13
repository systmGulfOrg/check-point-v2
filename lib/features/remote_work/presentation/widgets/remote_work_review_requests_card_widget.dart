import 'package:flutter/material.dart';
import 'package:check_point_v2/core/core.dart';
import '../../data/models/remote_work_request_model.dart';
import 'remote_work_request_card_widget.dart';

class RemoteWorkReviewRequestsCardWidget extends StatelessWidget {
  const RemoteWorkReviewRequestsCardWidget({
    required this.requests,
    required this.currentEmployeeId,
    required this.onApprove,
    required this.onReject,
    super.key,
  });

  final List<RemoteWorkRequestModel> requests;
  final String? currentEmployeeId;
  final ValueChanged<String> onApprove;
  final ValueChanged<String> onReject;

  @override
  Widget build(BuildContext context) {
    return AppCardContainerWidget(
      padding: EdgeInsets.zero,
      child: Column(
        children: requests.asMap().entries.map((entry) {
          final request = entry.value;
          final isLast = entry.key == requests.length - 1;
          return Column(
            children: [
              RemoteWorkRequestCardWidget(
                request: request,
                canReview: true,
                isOwnRequest: request.employeeId == currentEmployeeId,
                showContainer: false,
                onApprove: () => onApprove(request.id),
                onReject: () => onReject(request.id),
              ),
              if (!isLast) const Divider(height: 1),
            ],
          );
        }).toList(),
      ),
    );
  }
}
