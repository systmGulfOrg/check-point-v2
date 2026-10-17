import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:check_point_v2/core/core.dart';

class TrialSignupCountryDropdownWidget extends StatelessWidget {
  const TrialSignupCountryDropdownWidget({
    required this.value,
    required this.onChanged,
    super.key,
  });

  final String? value;
  final ValueChanged<String?> onChanged;

  static const _countries = <String>[
    'Saudi Arabia',
    'United Arab Emirates',
    'Egypt',
    'Qatar',
    'Kuwait',
    'Bahrain',
    'Oman',
    'Jordan',
    'Iraq',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'auth.trialSignup.countryLabel'.tr(context: context),
          style: AppTextStyles.font14SemiBold,
        ),
        hSpace(10),
        DropdownButtonFormField<String>(
          initialValue: value,
          isExpanded: true,
          decoration: const InputDecoration(),
          items: _countries
              .map(
                (country) => DropdownMenuItem(
                  value: country,
                  child: Text(country, overflow: TextOverflow.ellipsis),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
