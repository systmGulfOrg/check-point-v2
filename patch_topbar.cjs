const fs = require('fs');
let topBarPath = 'lib/features/admin/presentation/widgets/admin_top_bar_widget.dart';
let code = fs.readFileSync(topBarPath, 'utf8');

// Add imports
if (!code.includes("import 'package:flutter_bloc/flutter_bloc.dart';")) {
  code = "import 'package:flutter_bloc/flutter_bloc.dart';\n" + code;
}
if (!code.includes("import 'package:check_point_v2/features/admin/presentation/cubit/pending_devices/admin_pending_devices_cubit.dart';")) {
  code = "import 'package:check_point_v2/features/admin/presentation/cubit/pending_devices/admin_pending_devices_cubit.dart';\n" + code;
}
if (!code.includes("import 'package:check_point_v2/features/admin/presentation/cubit/pending_devices/admin_pending_devices_state.dart';")) {
  code = "import 'package:check_point_v2/features/admin/presentation/cubit/pending_devices/admin_pending_devices_state.dart';\n" + code;
}

const badgeReplacement = `
          child: BlocBuilder<AdminPendingDevicesCubit, AdminPendingDevicesState>(
            builder: (context, state) {
              final pendingCount = state.maybeWhen(
                success: (devices) => devices.length,
                orElse: () => 0,
              );
              
              return Badge(
                isLabelVisible: pendingCount > 0,
                label: Text(pendingCount.toString()),
                backgroundColor: AppColors.error,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.adminPendingDevices);
                  },
                  icon: Icon(
                    Icons.notifications_none_rounded,
                    color: AppColors.brandInk,
                    size: 20.r,
                  ),
                ),
              );
            },
          ),
`;

// Find the child: IconButton( inside the Container
code = code.replace(/child: IconButton\([\s\S]*?size: 20\.r,\n\s*\),\n\s*\),/m, badgeReplacement.trim());

fs.writeFileSync(topBarPath, code);
