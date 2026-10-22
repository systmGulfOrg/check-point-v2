import 'package:flutter/material.dart';

import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/core/routing/push_route_resolver.dart';
import 'package:check_point_v2/core/routes/app_router.dart';
import 'package:check_point_v2/core/services/push_notification_service.dart';

class PushTapListenerWidget extends StatefulWidget {
  const PushTapListenerWidget({required this.child, super.key});

  final Widget child;

  @override
  State<PushTapListenerWidget> createState() => _PushTapListenerWidgetState();
}

class _PushTapListenerWidgetState extends State<PushTapListenerWidget> {
  @override
  void initState() {
    super.initState();
    sl<PushNotificationService>().tappedMessageData.addListener(_onTapped);
  }

  @override
  void dispose() {
    sl<PushNotificationService>().tappedMessageData.removeListener(_onTapped);
    super.dispose();
  }

  void _onTapped() {
    final data = sl<PushNotificationService>().tappedMessageData.value;
    if (data == null) return;

    final route = PushRouteResolver.resolve(data['type'] as String?, data);
    sl<PushNotificationService>().tappedMessageData.value = null;
    if (route == null) return;

    final navigator = AppRouter.navigatorKey.currentState;
    navigator?.pushNamed(route);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
