import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/core/core.dart';
import 'admin_location_card_widget.dart';
import 'admin_location_data.dart';

class AdminLocationsSkeletonWidget extends StatelessWidget {
  const AdminLocationsSkeletonWidget({this.itemCount = 4, super.key});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        separatorBuilder: (_, _) => hSpace(10),
        itemBuilder: (_, _) => const AdminLocationCardWidget(
          location: AdminLocationData(
            nameKey: 'Loading location name',
            descriptionKey: 'Loading location description',
            addressKey: 'Loading location address',
            statusKey: 'admin.locations.status.active',
            icon: Icons.location_on_outlined,
            iconColor: AppColors.info,
            iconBackgroundColor: AppColors.softBlueBackground,
          ),
        ),
      ),
    );
  }
}
