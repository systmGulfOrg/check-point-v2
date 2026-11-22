import '../../data/models/ai_chat_models.dart';

class AiSettingsState {
  final AiSettingsModel? settings;
  final bool loading;
  final bool saving;
  final String? error;
  const AiSettingsState({
    this.settings,
    this.loading = false,
    this.saving = false,
    this.error,
  });
  AiSettingsState copyWith({
    AiSettingsModel? settings,
    bool? loading,
    bool? saving,
    String? error,
  }) => AiSettingsState(
    settings: settings ?? this.settings,
    loading: loading ?? this.loading,
    saving: saving ?? this.saving,
    error: error,
  );
}
