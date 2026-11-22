import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:check_point_v2/core/core.dart';
import '../cubit/ai_settings_cubit.dart';
import '../cubit/ai_settings_state.dart';

class AiSettingsWidget extends StatefulWidget {
  const AiSettingsWidget({super.key});
  @override
  State<AiSettingsWidget> createState() => AiSettingsWidgetState();
}

class AiSettingsWidgetState extends State<AiSettingsWidget> {
  final controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => sl<AiSettingsCubit>()..load(),
    child: BlocBuilder<AiSettingsCubit, AiSettingsState>(
      builder: (context, state) {
        final enabled = state.settings?.enabled ?? false;
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'admin.settings.aiTitle'.tr(),
                  style: AppTextStyles.font16Bold,
                ),
                const SizedBox(height: 4),
                Text(
                  'admin.settings.aiHint'.tr(),
                  style: AppTextStyles.font12Regular,
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    enabled
                        ? 'admin.settings.aiOn'.tr()
                        : 'admin.settings.aiOff'.tr(),
                  ),
                  value: enabled,
                  onChanged: state.saving
                      ? null
                      : (v) => context.read<AiSettingsCubit>().save(enabled: v),
                ),
                TextField(
                  controller: controller,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'admin.settings.aiKey'.tr(),
                    hintText:
                        state.settings?.apiKeyMasked ??
                        'admin.settings.aiKeyHint'.tr(),
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: ElevatedButton(
                    onPressed: state.saving || controller.text.trim().isEmpty
                        ? null
                        : () async {
                            final key = controller.text.trim();
                            await context.read<AiSettingsCubit>().save(
                              enabled: true,
                              apiKey: key,
                            );
                            controller.clear();
                            if (context.mounted) {
                              CustomSnackBar.showSuccess(
                                context,
                                message: 'تم حفظ وتفعيل مفتاح الذكاء الاصطناعي بنجاح',
                              );
                            }
                          },
                    child: Text('admin.settings.aiSave'.tr()),
                  ),
                ),
                if (state.error != null)
                  Text(state.error!, style: const TextStyle(color: Colors.red)),
              ],
            ),
          ),
        );
      },
    ),
  );
}
