import 'package:dio/dio.dart';
import 'package:check_point_v2/core/core.dart';
import '../models/ai_chat_models.dart';

class AiApiService {
  final Dio dio;

  AiApiService({required this.dio});

  Future<AiSettingsModel> getSettings() async {
    final response = await dio.get(ApiConstants.aiSettings);
    final raw = response.data as Map<String, dynamic>;
    return AiSettingsModel.fromJson(
      (raw['value'] as Map<String, dynamic>?) ?? raw,
    );
  }

  Future<AiSettingsModel> updateSettings({
    required bool enabled,
    String? apiKey,
  }) async {
    final response = await dio.put(
      ApiConstants.aiSettings,
      data: {
        'enabled': enabled,
        if (apiKey != null && apiKey.trim().isNotEmpty) 'apiKey': apiKey.trim(),
      },
    );
    final raw = response.data as Map<String, dynamic>;
    return AiSettingsModel.fromJson(
      (raw['value'] as Map<String, dynamic>?) ?? raw,
    );
  }

  Future<AiChatResponseModel> sendMessage(
    String message, {
    String? threadId,
  }) async {
    try {
      final response = await dio.post(
        ApiConstants.aiChat,
        data: {
          'message': message,
          'query': message,
          if (threadId != null && threadId.isNotEmpty) 'thread_id': threadId,
          if (threadId != null && threadId.isNotEmpty) 'session_id': threadId,
        },
        options: Options(
          sendTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 35),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      final raw = response.data;
      final Map<String, dynamic> data =
          (raw is Map<String, dynamic> && raw['value'] is Map<String, dynamic>)
          ? raw['value'] as Map<String, dynamic>
          : (raw is Map<String, dynamic> ? raw : {});

      if (data['response'] != null) {
        return AiChatResponseModel.fromJson(data);
      }
      throw StateError('AI gateway returned an invalid response');
    } catch (_) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> confirmAction(
    String actionId, {
    bool confirmed = true,
    String? sessionId,
  }) async {
    // 1. Direct to AI agent confirm endpoint
    try {
      final response = await dio.post(
        ApiConstants.aiActionConfirm,
        data: {'action_id': actionId, 'session_id': sessionId ?? 'default'},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      final raw = response.data;
      if (raw is Map<String, dynamic>) {
        return raw;
      }
    } catch (_) {
      rethrow;
    }

    return {'success': true, 'message': 'تم تأكيد الإجراء بنجاح.'};
  }
}
