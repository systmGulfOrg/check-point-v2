import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';
import 'package:check_point_v2/core/widgets/custom_button.dart';
import 'package:check_point_v2/core/widgets/custom_text_form_field.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_cubit.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_state.dart';

class AdminSamcoSitesScreen extends StatefulWidget {
  const AdminSamcoSitesScreen({super.key});

  @override
  State<AdminSamcoSitesScreen> createState() => _AdminSamcoSitesScreenState();
}

class _AdminSamcoSitesScreenState extends State<AdminSamcoSitesScreen> {
  void _openCreateSite() {
    final nameController = TextEditingController();
    final codeController = TextEditingController();
    final radiusController = TextEditingController(text: '150');
    final latitudeController = TextEditingController();
    final longitudeController = TextEditingController();
    final polygonController = TextEditingController();
    var boundaryType = 'circle';
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.cardBackground,
      builder: (sheetContext) => StatefulBuilder(
        builder: (context, setSheetState) => Padding(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            top: 20.h,
            bottom: MediaQuery.viewInsetsOf(context).bottom + 20.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'admin.samco.createSite'.tr(),
                style: AppTextStyles.font16Bold,
              ),
              SizedBox(height: 12.h),
              CustomTextFormField(
                controller: nameController,
                hintText: 'admin.samco.siteName'.tr(),
              ),
              SizedBox(height: 10.h),
              CustomTextFormField(
                controller: codeController,
                hintText: 'admin.samco.siteCode'.tr(),
              ),
              SizedBox(height: 10.h),
              DropdownButtonFormField<String>(
                initialValue: boundaryType,
                decoration: InputDecoration(
                  labelText: 'admin.samco.boundaryType'.tr(),
                ),
                items: [
                  DropdownMenuItem(
                    value: 'circle',
                    child: Text('admin.samco.circle'.tr()),
                  ),
                  DropdownMenuItem(
                    value: 'polygon',
                    child: Text('admin.samco.polygon'.tr()),
                  ),
                ],
                onChanged: (value) =>
                    setSheetState(() => boundaryType = value ?? 'circle'),
              ),
              if (boundaryType == 'circle') ...[
                SizedBox(height: 10.h),
                CustomTextFormField(
                  controller: latitudeController,
                  hintText: 'admin.samco.latitude'.tr(),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: true,
                  ),
                ),
                SizedBox(height: 10.h),
                CustomTextFormField(
                  controller: longitudeController,
                  hintText: 'admin.samco.longitude'.tr(),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: true,
                  ),
                ),
                SizedBox(height: 10.h),
                CustomTextFormField(
                  controller: radiusController,
                  hintText: 'admin.samco.radius'.tr(),
                  keyboardType: TextInputType.number,
                ),
              ],
              if (boundaryType == 'polygon') ...[
                SizedBox(height: 10.h),
                CustomTextFormField(
                  controller: polygonController,
                  hintText: 'admin.samco.polygonCoordinates'.tr(),
                  maxLines: 3,
                ),
              ],
              SizedBox(height: 16.h),
              CustomButton(
                text: 'admin.samco.createSite'.tr(),
                onTap: () async {
                  if (nameController.text.trim().isEmpty) return;
                  final latitude = double.tryParse(
                    latitudeController.text.trim(),
                  );
                  final longitude = double.tryParse(
                    longitudeController.text.trim(),
                  );
                  final coordinates = polygonController.text
                      .split(';')
                      .map(
                        (point) => point
                            .split(',')
                            .map((value) => double.tryParse(value.trim()))
                            .toList(),
                      )
                      .where(
                        (point) =>
                            point.length == 2 &&
                            point[0] != null &&
                            point[1] != null,
                      )
                      .map(
                        (point) => {
                          'latitude': point[0],
                          'longitude': point[1],
                        },
                      )
                      .toList();
                  if (boundaryType == 'circle' &&
                      (latitude == null || longitude == null)) {
                    return;
                  }
                  if (boundaryType == 'polygon' && coordinates.length < 3) {
                    return;
                  }
                  final saved = await context
                      .read<ContractorCubit>()
                      .createSite({
                        'name': nameController.text.trim(),
                        'code': codeController.text.trim().isEmpty
                            ? null
                            : codeController.text.trim(),
                        'boundaryType': boundaryType,
                        'center_lat': latitude,
                        'center_lng': longitude,
                        'boundary_coordinates': coordinates,
                        'geofenceRadiusM':
                            double.tryParse(radiusController.text) ?? 150,
                      });
                  if (!sheetContext.mounted) return;
                  if (saved) Navigator.pop(sheetContext);
                },
              ),
            ],
          ),
        ),
      ),
    ).whenComplete(() {
      nameController.dispose();
      codeController.dispose();
      radiusController.dispose();
      latitudeController.dispose();
      longitudeController.dispose();
      polygonController.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        title: Text(
          'admin.samco.sites'.tr(),
          style: AppTextStyles.font16Bold.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        backgroundColor: AppColors.cardBackground,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openCreateSite,
        icon: const Icon(Icons.add_location_alt_outlined),
        label: Text('admin.samco.createSite'.tr()),
      ),
      body: BlocBuilder<ContractorCubit, ContractorState>(
        builder: (context, state) {
          final sites =
              state.mapOrNull(success: (value) => value.sites) ?? const [];
          if (sites.isEmpty) return Center(child: Text('no_data'.tr()));
          return ListView.separated(
            padding: EdgeInsets.all(16.r),
            itemCount: sites.length,
            separatorBuilder: (context, index) => SizedBox(height: 10.h),
            itemBuilder: (context, index) {
              final site = sites[index];
              return ListTile(
                tileColor: AppColors.cardBackground,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                  side: BorderSide(color: AppColors.border),
                ),
                leading: Icon(
                  site.boundaryType == 'polygon'
                      ? Icons.polyline
                      : Icons.radio_button_checked,
                  color: AppColors.brandPrimary,
                ),
                title: Text(site.siteName, style: AppTextStyles.font14Bold),
                subtitle: Text(
                  '${site.projectName ?? '-'} • ${site.workerCount} ${'supervisor.samco.totalWorkers'.tr()}',
                ),
                trailing: Text(site.status.tr()),
              );
            },
          );
        },
      ),
    );
  }
}
