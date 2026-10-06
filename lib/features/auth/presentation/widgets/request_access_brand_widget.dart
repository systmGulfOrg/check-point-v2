import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class RequestAccessBrandWidget extends StatelessWidget {
  const RequestAccessBrandWidget({super.key});

  @override
  Widget build(BuildContext context) => Image.asset(
    AppAssets.logo,
    height: 64.h,
    fit: BoxFit.contain,
  );
}
