import 'package:flutter/material.dart';

import 'package:check_point_v2/core/core.dart';
import 'admin_location_card_widget.dart';
import 'admin_location_data.dart';

enum AdminLocationCategory { branches, sites, customers }

class AdminLocationsTabWidget extends StatelessWidget {
  const AdminLocationsTabWidget({required this.category, super.key});

  final AdminLocationCategory category;

  static const _branches = <AdminLocationData>[
    AdminLocationData(
      nameKey: 'admin.locations.branches.headquarters.name',
      descriptionKey: 'admin.locations.branches.headquarters.description',
      addressKey: 'admin.locations.branches.headquarters.address',
      statusKey: 'admin.locations.status.inactive',
      icon: Icons.home_work_outlined,
      iconColor: AppColors.info,
      iconBackgroundColor: AppColors.softBlueBackground,
      isGeofenced: true,
    ),
  ];

  static const _sites = <AdminLocationData>[
    AdminLocationData(
      nameKey: 'admin.locations.sites.construction.name',
      descriptionKey: 'admin.locations.sites.construction.description',
      addressKey: 'admin.locations.sites.construction.address',
      statusKey: 'admin.locations.status.active',
      icon: Icons.map_outlined,
      iconColor: AppColors.info,
      iconBackgroundColor: AppColors.softBlueBackground,
      isGeofenced: true,
    ),
  ];

  static const _customers = <AdminLocationData>[
    AdminLocationData(
      nameKey: 'admin.locations.customers.futtaim.name',
      descriptionKey: 'admin.locations.customers.futtaim.description',
      addressKey: 'admin.locations.customers.futtaim.address',
      statusKey: 'admin.locations.status.active',
      icon: Icons.people_outline_rounded,
      iconColor: AppColors.info,
      iconBackgroundColor: AppColors.softBlueBackground,
      isGeofenced: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final locations = switch (category) {
      AdminLocationCategory.branches => _branches,
      AdminLocationCategory.sites => _sites,
      AdminLocationCategory.customers => _customers,
    };
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: locations.length,
      separatorBuilder: (_, _) => hSpace(10),
      itemBuilder: (_, index) =>
          AdminLocationCardWidget(location: locations[index]),
    );
  }
}
