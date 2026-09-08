import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/core/services/google_places_service.dart';
import 'package:check_point_v2/core/services/location_link_parser.dart';
import 'package:check_point_v2/core/services/location_service.dart';
import 'admin_location_search_bar_widget.dart';
import 'admin_location_suggestions_list_widget.dart';

class AdminFullMapPickerDialogWidget extends StatefulWidget {
  const AdminFullMapPickerDialogWidget({
    required this.initialPoints,
    required this.initialAddress,
    super.key,
  });

  final List<LatLng> initialPoints;
  final String initialAddress;

  @override
  State<AdminFullMapPickerDialogWidget> createState() =>
      _AdminFullMapPickerDialogWidgetState();
}

class _AdminFullMapPickerDialogWidgetState
    extends State<AdminFullMapPickerDialogWidget> {
  final TextEditingController _searchController = TextEditingController();
  final List<LatLng> _points = [];
  String _selectedAddress = '';
  List<GooglePlaceSuggestion> _suggestions = [];
  GoogleMapController? _mapController;
  Timer? _debounce;
  bool _isSearching = false;
  bool _isLocating = false;

  late final GooglePlacesService _placesService;
  late final LocationService _locationService;

  @override
  void initState() {
    super.initState();
    _placesService = sl<GooglePlacesService>();
    _locationService = sl<LocationService>();
    _points.addAll(widget.initialPoints);
    _selectedAddress = widget.initialAddress;
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  LatLng _getCenter() {
    if (_points.isEmpty) return const LatLng(30.0444, 31.2357);
    double lat = 0;
    double lng = 0;
    for (final p in _points) {
      lat += p.latitude;
      lng += p.longitude;
    }
    return LatLng(lat / _points.length, lng / _points.length);
  }

  void _centerOnPoints() {
    if (_points.isEmpty || _mapController == null) return;
    final center = _getCenter();
    final zoom = _points.length == 1 ? 18.5 : 18.0;
    _mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: center, zoom: zoom),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    if (_points.isNotEmpty) {
      _centerOnPoints();
    }
  }

  void _onMapTap(LatLng point) {
    setState(() {
      _points.add(point);
    });
    if (_points.length == 1 && _selectedAddress.isEmpty) {
      _resolveAddressForPoint(point);
    }
  }

  Future<void> _resolveAddressForPoint(LatLng point) async {
    final address = await _locationService.getAddressFromCoordinates(
      point.latitude,
      point.longitude,
      localeIdentifier: context.locale.languageCode,
    );
    if (!mounted || address == null) return;
    setState(() {
      _selectedAddress = address;
    });
  }

  Future<void> _fetchCurrentLocation() async {
    setState(() => _isLocating = true);
    final position = await _locationService.getCurrentPosition();
    if (!mounted) return;
    setState(() => _isLocating = false);

    if (position != null) {
      setState(() {
        _points.add(position);
      });
      await _mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: position, zoom: 16),
        ),
      );
      _resolveAddressForPoint(position);
    }
  }

  Future<void> _pasteAndParseLink() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    final text = data?.text ?? _searchController.text;
    if (text.isNotEmpty) {
      _searchController.text = text;
      _onSearchChanged(text);
    }
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();
    if (query.trim().isEmpty) {
      setState(() {
        _suggestions = [];
        _isSearching = false;
      });
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 300), () async {
      setState(() => _isSearching = true);
      final parsed = await LocationLinkParser.parseLocation(query);
      if (!mounted) return;

      if (parsed != null) {
        setState(() {
          _suggestions = [];
          _isSearching = false;
          _points.add(parsed);
        });
        await _mapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: parsed, zoom: 16),
          ),
        );
        _resolveAddressForPoint(parsed);
        return;
      }

      final results = await _placesService.autocomplete(
        query,
        language: context.locale.languageCode,
      );
      if (!mounted) return;
      setState(() {
        _suggestions = results;
        _isSearching = false;
      });
    });
  }

  Future<void> _selectSuggestion(GooglePlaceSuggestion suggestion) async {
    final location = await _placesService.getPlaceLocation(
      suggestion.placeId,
      language: context.locale.languageCode,
    );
    if (!mounted || location == null) return;

    _searchController.text = suggestion.description;
    setState(() {
      _suggestions = [];
      _points.add(location.latLng);
      _selectedAddress = location.address;
    });

    await _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: location.latLng, zoom: 16),
      ),
    );
  }

  void _undoPoint() {
    if (_points.isEmpty) return;
    setState(() {
      _points.removeLast();
    });
  }

  void _clearPoints() {
    setState(() {
      _points.clear();
      _selectedAddress = '';
    });
  }

  void _onDone() {
    Navigator.pop(context, {'points': _points, 'address': _selectedAddress});
  }

  @override
  Widget build(BuildContext context) {
    final markers = _points
        .map(
          (point) => Marker(
            markerId: MarkerId('${point.latitude}_${point.longitude}'),
            position: point,
          ),
        )
        .toSet();

    final polygons = _points.length >= 2
        ? {
            Polygon(
              polygonId: const PolygonId('geofence_poly'),
              points: _points,
              strokeWidth: 2,
              strokeColor: AppColors.brandPrimary,
              fillColor: AppColors.brandPrimary.withValues(alpha: 0.2),
            ),
          }
        : <Polygon>{};

    final circles = _points.length == 1
        ? {
            Circle(
              circleId: const CircleId('geofence_circle'),
              center: _points.first,
              radius: 100,
              strokeWidth: 2,
              strokeColor: AppColors.brandPrimary,
              fillColor: AppColors.brandPrimary.withValues(alpha: 0.2),
            ),
          }
        : <Circle>{};

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: Text(
          'admin.locations.create.geofenceTitle'.tr(context: context),
          style: AppTextStyles.font16Bold,
        ),
        actions: [
          TextButton(
            onPressed: _onDone,
            child: Text(
              'admin.locations.create.save'.tr(context: context),
              style: AppTextStyles.font14Bold.copyWith(
                color: AppColors.brandPrimary,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            onTap: _onMapTap,
            initialCameraPosition: CameraPosition(
              target: _getCenter(),
              zoom: _points.isNotEmpty
                  ? (_points.length == 1 ? 18.5 : 18.0)
                  : 12.0,
            ),
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
            markers: markers,
            polygons: polygons,
            circles: circles,
          ),
          Positioned(
            top: 12.h,
            left: 16.w,
            right: 16.w,
            child: Column(
              children: [
                AdminLocationSearchBarWidget(
                  controller: _searchController,
                  isSearching: _isSearching,
                  isLocating: _isLocating,
                  onSearchChanged: _onSearchChanged,
                  onGoPressed: () => _onSearchChanged(_searchController.text),
                  onPasteLinkPressed: _pasteAndParseLink,
                  onCurrentLocationPressed: _fetchCurrentLocation,
                ),
                AdminLocationSuggestionsListWidget(
                  suggestions: _suggestions,
                  onSelected: _selectSuggestion,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 24.h,
            left: 16.w,
            right: 16.w,
            child: Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_selectedAddress.isNotEmpty) ...[
                    Text(
                      _selectedAddress,
                      style: AppTextStyles.font12Regular,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    hSpace(8),
                  ],
                  Row(
                    children: [
                      if (_points.isNotEmpty) ...[
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _undoPoint,
                            child: Text(
                              'admin.locations.create.undoPoint'.tr(
                                context: context,
                              ),
                            ),
                          ),
                        ),
                        vSpace(8),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _clearPoints,
                            child: Text(
                              'admin.locations.create.clearPoints'.tr(
                                context: context,
                              ),
                            ),
                          ),
                        ),
                        vSpace(8),
                      ],
                      Expanded(
                        child: CustomButton(
                          text: 'admin.locations.create.save'.tr(
                            context: context,
                          ),
                          onTap: _onDone,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
