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

  AiChatResponseModel _buildSmartClientFallback(
    String message,
    String? threadId,
  ) {
    final q = message.toLowerCase();
    String responseText =
        'أهلاً بك! أنا **المساعد الذكي لمنظومة CHECK-POINT**. 🤖✨\n\nكيف يمكنني مساعدتك في مهام العمل، الحضور، أو الإجازات اليوم؟';
    List<String> targetAgents = ['supervisor'];

    if (q.contains('إجاز') ||
        q.contains('اجاز') ||
        q.contains('leave') ||
        q.contains('vacation')) {
      responseText =
          '📋 **مساعد الموارد البشرية (HR Assistant)**\n\n- يمكنك تقديم طلب إجازة جديد أو الاستعلام عن رصيدك من تبويب الإجازات.\n- يتم فحص الأرصدة والسياسات المعتمدة آلياً.\n\nهل ترغب في فتح شاشة تقديم طلب إجازة؟';
      targetAgents = ['hr'];
    } else if (q.contains('حضور') ||
        q.contains('تأخير') ||
        q.contains('متأخر') ||
        q.contains('attendance') ||
        q.contains('late')) {
      responseText =
          '⏱️ **مساعد الحضور والانصراف (Attendance Intelligence)**\n\n- يتم تسجيل الحضور بدقة متناهية مع فحص الموقع والبصمة الحيوية.\n- لوحة تحكم الحضور اليومي في الإدارة تعرض ملخص الحضور والتأخيرات الحالية.\n\nجميع الحركات مراقبة ومحمية بنظام مكافحة التلاعب.';
      targetAgents = ['attendance'];
    } else if (q.contains('مهم') ||
        q.contains('مهام') ||
        q.contains('task') ||
        q.contains('مشروع') ||
        q.contains('project')) {
      responseText =
          '📌 **مساعد إدارة المهام (Task Assistant)**\n\n- يمكنك استعراض لوحة المهام والمشاريع من الشاشة الرئيسية.\n- يمكنك توزيع المهام على أعضاء الفريق ومتابعة نسبة الإنجاز.';
      targetAgents = ['task'];
    } else if (q.contains('تقرير') ||
        q.contains('ملخص') ||
        q.contains('report') ||
        q.contains('summary')) {
      responseText =
          '📊 **مساعد التقارير الذكية (Report Generator)**\n\n- تقرير الحضور والغياب الأسبوعي متاح للتصدير.\n- تقرير النقاط والإنتاجية محدث ومتاح لجميع الفروع.';
      targetAgents = ['report'];
    }

    return AiChatResponseModel(
      success: true,
      response: responseText,
      threadId: threadId ?? 'th_${DateTime.now().millisecondsSinceEpoch}',
      targetAgents: targetAgents,
    );
  }
}
