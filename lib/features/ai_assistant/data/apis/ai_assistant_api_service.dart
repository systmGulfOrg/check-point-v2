import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/ai_chat_models.dart';

part 'ai_assistant_api_service.g.dart';

@RestApi()
abstract class AiAssistantApiService {
  factory AiAssistantApiService(Dio dio, {String? baseUrl}) =
      _AiAssistantApiService;

  @POST('/api/v2/ai/chat')
  Future<AiChatResponseModel> sendChatMessage(
    @Body() AiChatRequestBody body,
  );
}
