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
import 'admin_full_map_picker_dialog_widget.dart';
import 'admin_location_map_controls_widget.dart';
import 'admin_location_search_bar_widget.dart';
import 'admin_location_suggestions_list_widget.dart';

class AdminLocationMapPickerWidget extends StatefulWidget {
  const AdminLocationMapPickerWidget({
    required this.initialPoints,
    required this.initialAddress,
    required this.onPointsChanged,
    required this.onAddressResolved,
    super.key,
  });

  final List<LatLng> initialPoints;
  final String initialAddress;
  final ValueChanged<List<LatLng>> onPointsChanged;
  final ValueChanged<String> onAddressResolved;

  @override
  State<AdminLocationMapPickerWidget> createState() =>
      _AdminLocationMapPickerWidgetState();
}

class _AdminLocationMapPickerWidgetState
    extends State<AdminLocationMapPickerWidget> {
  final TextEditingController _searchController = TextEditingController();
  final List<LatLng> _points = [];
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

  @override
  void didUpdateWidget(covariant AdminLocationMapPickerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialPoints != oldWidget.initialPoints) {
      setState(() {
        _points
          ..clear()
          ..addAll(widget.initialPoints);
      });
      if (_points.isNotEmpty) {
        _centerOnPoints();
      }
    }
  }

  void _onMapTap(LatLng point) {
    setState(() {
      _points.add(point);
    });
    widget.onPointsChanged(List.unmodifiable(_points));
    if (_points.length == 1 && widget.initialAddress.isEmpty) {
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
    widget.onAddressResolved(address);
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
      widget.onPointsChanged(List.unmodifiable(_points));
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

  Future<void> _handleGoPressed() async {
    final lang = context.locale.languageCode;
    final query = _searchController.text.trim();
    if (query.isEmpty) return;
    setState(() => _isSearching = true);

    final parsed = await LocationLinkParser.parseLocation(query);
    if (parsed != null && mounted) {
      setState(() {
        _suggestions = [];
        _isSearching = false;
        _points.add(parsed);
      });
      widget.onPointsChanged(List.unmodifiable(_points));
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
      language: lang,
    );
    if (!mounted) return;

    if (results.isNotEmpty) {
      await _selectSuggestion(results.first);
      setState(() => _isSearching = false);
      return;
    }

    // Geocoding device fallback
    final coords = await _locationService.getCoordinatesFromAddress(query);
    if (!mounted) return;
    setState(() => _isSearching = false);

    if (coords != null) {
      setState(() {
        _suggestions = [];
        _points.add(coords);
      });
      widget.onPointsChanged(List.unmodifiable(_points));
      await _mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: coords, zoom: 15),
        ),
      );
      _resolveAddressForPoint(coords);
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
        widget.onPointsChanged(List.unmodifiable(_points));
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

      if (results.isEmpty) {
        // Try fallback coordinates check
        final coords = await _locationService.getCoordinatesFromAddress(query);
        if (!mounted) return;
        if (coords != null) {
          setState(() {
            _suggestions = [
              GooglePlaceSuggestion(
                placeId: 'geo:${coords.latitude},${coords.longitude}',
                description: query,
              ),
            ];
            _isSearching = false;
          });
          return;
        }
      }

      setState(() {
        _suggestions = results;
        _isSearching = false;
      });
    });
  }

  Future<void> _selectSuggestion(GooglePlaceSuggestion suggestion) async {
    LatLng? point;
    String address = suggestion.description;

    if (suggestion.placeId.startsWith('geo:')) {
      final raw = suggestion.placeId.substring(4).split(',');
      if (raw.length == 2) {
        final lat = double.tryParse(raw[0]);
        final lng = double.tryParse(raw[1]);
        if (lat != null && lng != null) {
          point = LatLng(lat, lng);
        }
      }
    } else {
      final location = await _placesService.getPlaceLocation(
        suggestion.placeId,
        language: context.locale.languageCode,
      );
      if (location != null) {
        point = location.latLng;
        address = location.address.isNotEmpty ? location.address : address;
      }
    }

    if (!mounted || point == null) return;

    _searchController.text = suggestion.description;
    setState(() {
      _suggestions = [];
      _points.add(point!);
    });
    widget.onPointsChanged(List.unmodifiable(_points));
    widget.onAddressResolved(address);

    await _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: point, zoom: 16),
      ),
    );
  }

  void _undoPoint() {
    if (_points.isEmpty) return;
    setState(() {
      _points.removeLast();
    });
    widget.onPointsChanged(List.unmodifiable(_points));
  }

  void _clearPoints() {
    setState(() {
      _points.clear();
    });
    widget.onPointsChanged(const []);
  }

  Future<void> _expandMap() async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (_) => AdminFullMapPickerDialogWidget(
          initialPoints: _points,
          initialAddress: widget.initialAddress,
        ),
      ),
    );

    if (result != null && mounted) {
      final updatedPoints = result['points'] as List<LatLng>?;
      final updatedAddress = result['address'] as String?;
      if (updatedPoints != null) {
        setState(() {
          _points
            ..clear()
            ..addAll(updatedPoints);
        });
        widget.onPointsChanged(List.unmodifiable(_points));
      }
      if (updatedAddress != null && updatedAddress.isNotEmpty) {
        widget.onAddressResolved(updatedAddress);
      }
    }
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AdminLocationSearchBarWidget(
          controller: _searchController,
          isSearching: _isSearching,
          isLocating: _isLocating,
          onSearchChanged: _onSearchChanged,
          onGoPressed: _handleGoPressed,
          onPasteLinkPressed: _pasteAndParseLink,
          onCurrentLocationPressed: _fetchCurrentLocation,
        ),
        AdminLocationSuggestionsListWidget(
          suggestions: _suggestions,
          onSelected: _selectSuggestion,
        ),
        hSpace(8),
        AdminLocationMapControlsWidget(
          pointsCount: _points.length,
          onUndo: _undoPoint,
          onClear: _clearPoints,
          onExpand: _expandMap,
        ),
        hSpace(8),
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            height: 200.h,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Stack(
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
                  zoomControlsEnabled: false,
                ),
                Positioned(
                  bottom: 8.h,
                  right: 8.w,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () => _mapController?.animateCamera(
                          CameraUpdate.zoomIn(),
                        ),
                        child: Container(
                          width: 32.r,
                          height: 32.r,
                          decoration: BoxDecoration(
                            color: AppColors.cardBackground,
                            shape: BoxShape.circle,
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.shadow,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.add_rounded,
                            size: 20.r,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      hSpace(4),
                      InkWell(
                        onTap: () => _mapController?.animateCamera(
                          CameraUpdate.zoomOut(),
                        ),
                        child: Container(
                          width: 32.r,
                          height: 32.r,
                          decoration: BoxDecoration(
                            color: AppColors.cardBackground,
                            shape: BoxShape.circle,
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.shadow,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.remove_rounded,
                            size: 20.r,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (_points.isNotEmpty)
                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: InkWell(
                      onTap: _centerOnPoints,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.shadow,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.center_focus_strong_rounded,
                              size: 14.r,
                              color: AppColors.brandPrimary,
                            ),
                            vSpace(4),
                            Text(
                              'Focus',
                              style: AppTextStyles.font12Medium.copyWith(
                                color: AppColors.brandPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
