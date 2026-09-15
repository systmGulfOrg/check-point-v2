const fs = require('fs');

let sheetPath = 'lib/features/employee/presentation/widgets/employee_details_sheet_widget.dart';
let sheetCode = fs.readFileSync(sheetPath, 'utf8');

sheetCode = sheetCode.replace(
  "        ],\n      ),\n    );\n  }\n\n  Widget _infoItem(BuildContext context, String label, String value) {",
  `          if (devicesHistory.isNotEmpty) ...[
            hSpace(20),
            Text('Device History', style: AppTextStyles.font16Bold),
            hSpace(10),
            for (final device in devicesHistory)
              Container(
                margin: EdgeInsets.only(bottom: 8.h),
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: AppColors.pageBackground,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppDateFormatter.formatDateString(device.createdAt.toString()),
                          style: AppTextStyles.font12Medium.copyWith(color: AppColors.textSecondary),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: device.isActive ? AppColors.softGreenBackground : AppColors.softBrandBackground,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            device.isActive ? 'Active' : 'Revoked/Pending',
                            style: AppTextStyles.font10Bold.copyWith(
                              color: device.isActive ? AppColors.success : AppColors.brandPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    hSpace(8),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            device.deviceId,
                            style: AppTextStyles.font13SemiBold,
                          ),
                        ),
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: Icon(Icons.copy, size: 16.r, color: AppColors.brandPrimary),
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: device.deviceId));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Device ID copied to clipboard')),
                            );
                          },
                        ),
                      ],
                    ),
                    if (device.deviceModel != null) ...[
                      hSpace(4),
                      Text(device.deviceModel ?? '', style: AppTextStyles.font12Regular),
                    ]
                  ],
                ),
              ),
          ]
        ],
      ),
    );
  }

  Widget _infoItem(BuildContext context, String label, String value) {`
);

fs.writeFileSync(sheetPath, sheetCode);
