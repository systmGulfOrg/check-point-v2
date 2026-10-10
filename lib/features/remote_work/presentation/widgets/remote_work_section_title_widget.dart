import 'package:flutter/material.dart';

import 'package:check_point_v2/core/core.dart';

class RemoteWorkSectionTitleWidget extends StatelessWidget {
  const RemoteWorkSectionTitleWidget({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) =>
      Text(title, style: AppTextStyles.font16Bold);
}
