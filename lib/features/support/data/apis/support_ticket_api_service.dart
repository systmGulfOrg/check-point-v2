import 'package:dio/dio.dart';
import 'package:check_point_v2/core/network/api_constants.dart';

/// API service for submitting support tickets, feedback and bug reports.
class SupportTicketApiService {
  SupportTicketApiService({required this.dio});

  final Dio dio;

  /// Submits a support ticket to `POST /api/v2/support-tickets`.
  ///
  /// [type] must be one of: 'bug', 'feedback', 'support', 'issue'
  /// [priority] must be one of: 'low', 'medium', 'high', 'critical'
  Future<void> submit({
    required String title,
    required String description,
    required String type,
    String priority = 'medium',
    String? pageUrl,
  }) async {
    await dio.post<void>(
      ApiConstants.supportTickets,
      data: {
        'title': title,
        'description': description,
        'type': type,
        'priority': priority,
        'pageUrl': pageUrl,
      },
    );
  }
}
