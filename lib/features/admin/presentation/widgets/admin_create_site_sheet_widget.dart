import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_cubit.dart';

class AdminCreateSiteSheetWidget extends StatefulWidget {
  const AdminCreateSiteSheetWidget({super.key});

  @override
  State<AdminCreateSiteSheetWidget> createState() =>
      _AdminCreateSiteSheetWidgetState();
}

class _AdminCreateSiteSheetWidgetState
    extends State<AdminCreateSiteSheetWidget> {
  late final TextEditingController nameController;
  late final TextEditingController codeController;
  late final TextEditingController latitudeController;
  late final TextEditingController longitudeController;
  late final TextEditingController radiusController;
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    codeController = TextEditingController();
    latitudeController = TextEditingController();
    longitudeController = TextEditingController();
    radiusController = TextEditingController(text: '150');
  }

  @override
  void dispose() {
    nameController.dispose();
    codeController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();
    radiusController.dispose();
    super.dispose();
  }

  Future<void> save() async {
    final name = nameController.text.trim();
    final latitude = double.tryParse(latitudeController.text.trim());
    final longitude = double.tryParse(longitudeController.text.trim());
    final radius = double.tryParse(radiusController.text.trim());
    if (name.isEmpty ||
        latitude == null ||
        longitude == null ||
        radius == null ||
        radius <= 0) {
      return;
    }
    setState(() => isSaving = true);
    final saved = await context.read<ContractorCubit>().createSite({
      'name': name,
      'code': codeController.text.trim().isEmpty
          ? null
          : codeController.text.trim(),
      'boundaryType': 'circle',
      'center_lat': latitude,
      'center_lng': longitude,
      'geofenceRadiusM': radius,
    });
    if (!mounted) return;
    if (saved) Navigator.pop(context);
    setState(() => isSaving = false);
  }

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Padding(
      padding: EdgeInsets.fromLTRB(
        20.w,
        18.h,
        20.w,
        16.h + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'admin.locations.create.siteTitle'.tr(context: context),
              style: AppTextStyles.font18Bold,
            ),
            hSpace(14),
            CustomTextFormField(
              controller: nameController,
              hintText: 'admin.locations.create.nameHint'.tr(context: context),
            ),
            hSpace(10),
            CustomTextFormField(
              controller: codeController,
              hintText: 'admin.locations.create.siteCodeHint'.tr(
                context: context,
              ),
            ),
            hSpace(10),
            CustomTextFormField(
              controller: latitudeController,
              hintText: 'admin.locations.create.latitudeHint'.tr(
                context: context,
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
            ),
            hSpace(10),
            CustomTextFormField(
              controller: longitudeController,
              hintText: 'admin.locations.create.longitudeHint'.tr(
                context: context,
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
            ),
            hSpace(10),
            CustomTextFormField(
              controller: radiusController,
              hintText: 'admin.locations.create.radiusHint'.tr(
                context: context,
              ),
              keyboardType: TextInputType.number,
            ),
            hSpace(16),
            CustomButton(
              text: 'admin.locations.create.save'.tr(context: context),
              onTap: save,
              isLoading: isSaving,
            ),
          ],
        ),
      ),
    ),
  );
}
