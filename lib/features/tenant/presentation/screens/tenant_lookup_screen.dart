import 'package:flutter/material.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/auth_card_widget.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/auth_shell_widget.dart';
import 'package:check_point_v2/features/tenant/presentation/widgets/tenant_lookup_bloc_listener_widget.dart';
import 'package:check_point_v2/features/tenant/presentation/widgets/tenant_lookup_form_widget.dart';
import 'package:check_point_v2/features/tenant/presentation/widgets/tenant_lookup_header_widget.dart';

class TenantLookupScreen extends StatelessWidget {
  const TenantLookupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TenantLookupBlocListenerWidget(
      child: AuthShellWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Align(
              alignment: AlignmentDirectional.centerEnd,
              child: LanguageSwitcherWidget(),
            ),
            hSpace(16),
            AuthCardWidget(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const TenantLookupHeaderWidget(),
                  hSpace(24),
                  const TenantLookupFormWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
