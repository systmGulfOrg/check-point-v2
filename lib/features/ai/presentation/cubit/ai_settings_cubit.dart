import 'package:check_point_v2/core/core.dart';
import '../../data/repos/ai_repo.dart';
import 'ai_settings_state.dart';

class AiSettingsCubit extends SafeCubit<AiSettingsState> {
  AiSettingsCubit({required this.repo}) : super(const AiSettingsState());
  final AiRepo repo;

  Future<void> load() async {
    emit(const AiSettingsState(loading: true));
    final result = await repo.getSettings();
    result.when(
      success: (value) => safeEmit(AiSettingsState(settings: value)),
      failure: (f) => safeEmit(AiSettingsState(error: f.messageKey)),
    );
  }

  Future<void> save({required bool enabled, String? apiKey}) async {
    emit(AiSettingsState(settings: state.settings, saving: true));
    final result = await repo.updateSettings(enabled: enabled, apiKey: apiKey);
    result.when(
      success: (value) => safeEmit(AiSettingsState(settings: value)),
      failure: (f) => safeEmit(
        AiSettingsState(settings: state.settings, error: f.messageKey),
      ),
    );
  }
}
