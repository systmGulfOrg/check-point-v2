import 'package:flutter/material.dart';

import '../../../notifications/presentation/widgets/notification_card_widget.dart';

class SupervisorNotificationCardWidget extends StatelessWidget {
  const SupervisorNotificationCardWidget({
    required this.typeKey,
    required this.titleKey,
    required this.messageKey,
    required this.isWarning,
    this.onTap,
    super.key,
  });

  final String typeKey;
  final String titleKey;
  final String messageKey;
  final bool isWarning;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return NotificationCardWidget(
      typeKey: typeKey,
      titleKey: titleKey,
      messageKey: messageKey,
      isWarning: isWarning,
      onTap: onTap,
    );
  }
}
