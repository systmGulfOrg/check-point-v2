import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/services/location_link_parser.dart';
import 'package:check_point_v2/features/admin/data/models/locations/branch_request_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_request_model.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_branches_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_customers_cubit.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_cubit.dart';
import 'admin_location_form_fields_widget.dart';
import 'admin_location_map_picker_widget.dart';
import 'admin_location_sheet_actions_widget.dart';
import 'admin_location_sheet_header_widget.dart';
import 'admin_locations_tab_widget.dart';

class AdminCreateLocationSheetWidget extends StatefulWidget {
  const AdminCreateLocationSheetWidget({
    required this.category,
    this.editBranchId,
    this.editCustomerId,
    this.initialName,
    this.initialAddress,
    this.initialDescription,
    this.initialPoints = const [],
    super.key,
  });

  final AdminLocationCategory category;
  final int? editBranchId;
  final String? editCustomerId;
  final String? initialName;
  final String? initialAddress;
  final String? initialDescription;
  final List<LatLng> initialPoints;

  bool get isEdit => editBranchId != null || editCustomerId != null;

  @override
  State<AdminCreateLocationSheetWidget> createState() =>
      _AdminCreateLocationSheetWidgetState();
}

class _AdminCreateLocationSheetWidgetState
    extends State<AdminCreateLocationSheetWidget> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _addressController;
  late final TextEditingController _descriptionController;
  final List<LatLng> _points = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName ?? '');
    _addressController = TextEditingController(
      text: widget.initialAddress ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.initialDescription ?? '',
    );
    _points.addAll(widget.initialPoints);
    if (_points.isEmpty && widget.initialAddress != null) {
      _tryParseInitialAddress(widget.initialAddress!);
    }
  }

  Future<void> _tryParseInitialAddress(String address) async {
    final parsed = await LocationLinkParser.parseLocation(address);
    if (parsed != null && mounted && _points.isEmpty) {
      setState(() {
        _points.add(parsed);
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final name = _nameController.text.trim();
      final address = _addressController.text.trim();
      final description = _descriptionController.text.trim();
      late final bool saved;

      switch (widget.category) {
        case AdminLocationCategory.branches:
          final coordinates = _points
              .map(
                (p) => BranchCoordinateModel(
                  latitude: p.latitude,
                  longitude: p.longitude,
                ),
              )
              .toList();
          final request = BranchRequestModel(
            name: name,
            location: address,
            description: description,
            coordinates: coordinates,
          );
          if (widget.editBranchId != null) {
            saved = await context.read<AdminBranchesCubit>().edit(
              id: widget.editBranchId!,
              request: request,
            );
          } else {
            saved = await context.read<AdminBranchesCubit>().add(request);
          }
        case AdminLocationCategory.sites:
          ContractorCubit? contractorCubit;
          try {
            contractorCubit = context.read<ContractorCubit>();
          } catch (_) {}

          if (contractorCubit != null && widget.editCustomerId == null) {
            final firstPoint = _points.isNotEmpty ? _points.first : null;
            final coordinates = _points
                .map(
                  (p) => {
                    'latitude': p.latitude,
                    'longitude': p.longitude,
                  },
                )
                .toList();
            saved = await contractorCubit.createSite({
              'name': name,
              'location': address,
              'projectName': description.isNotEmpty ? description : null,
              'boundaryType': _points.length > 2 ? 'polygon' : 'circle',
              'center_lat': firstPoint?.latitude ?? 0.0,
              'center_lng': firstPoint?.longitude ?? 0.0,
              'geofenceRadiusM': 150,
              'coordinates': coordinates,
              'boundaryCoordinates': coordinates,
            });
          } else {
            final coordinates = _points
                .map(
                  (p) => CustomerCoordinateModel(
                    latitude: p.latitude,
                    longitude: p.longitude,
                  ),
                )
                .toList();
            final request = CustomerRequestModel(
              name: name,
              location: address,
              workesAs: description,
              customerType: 'Site',
              coordinates: coordinates,
            );
            if (widget.editCustomerId != null) {
              saved = await context.read<AdminCustomersCubit>().edit(
                widget.editCustomerId!,
                request,
              );
            } else {
              saved = await context.read<AdminCustomersCubit>().add(request);
            }
          }
      }

      if (mounted && saved) {
        Navigator.pop(context);
        CustomSnackBar.showSuccess(
          context,
          message: 'admin.locations.create.successMessage'.tr(context: context),
        );
      } else if (mounted) {
        setState(() => _isLoading = false);
      }
    } catch (_) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          20.w,
          18.h,
          20.w,
          16.h + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AdminLocationSheetHeaderWidget(
                  category: widget.category,
                  isEdit: widget.isEdit,
                  onClose: () => Navigator.pop(context),
                ),
                hSpace(14),
                AdminLocationFormFieldsWidget(
                  category: widget.category,
                  nameController: _nameController,
                  addressController: _addressController,
                  descriptionController: _descriptionController,
                ),
                AdminLocationMapPickerWidget(
                  initialPoints: _points,
                  initialAddress: _addressController.text,
                  onPointsChanged: (points) {
                    _points
                      ..clear()
                      ..addAll(points);
                  },
                  onAddressResolved: (address) {
                    setState(() {
                      _addressController.text = address;
                    });
                  },
                ),
                hSpace(16),
                AdminLocationSheetActionsWidget(
                  isLoading: _isLoading,
                  onCancel: () => Navigator.pop(context),
                  onSave: _handleSave,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
