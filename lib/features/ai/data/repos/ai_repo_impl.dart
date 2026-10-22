import 'package:check_point_v2/core/network/api_failure_mapper.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import '../apis/ai_api_service.dart';
import '../models/ai_chat_models.dart';
import 'ai_repo.dart';

class AiRepoImpl implements AiRepo {
  final AiApiService api;

  AiRepoImpl({required this.api});

  @override
  Future<ApiResult<AiChatResponseModel>> sendMessage(
    String message, {
    String? threadId,
  }) async {
    try {
      final result = await api.sendMessage(message, threadId: threadId);
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<String>> confirmAction(
    String actionId, {
    bool confirmed = true,
  }) async {
    try {
      final res = await api.confirmAction(actionId, confirmed: confirmed);
      final msg = res['message']?.toString() ?? 'Action executed successfully';
      return ApiResult.success(msg);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }
}
