enum LocationIntegrityStatus {
  trusted,

  mockLocationDetected,

  locationAnomaly,

  lowAccuracy,

  unknown,
}

class LocationIntegrityResult {
  const LocationIntegrityResult({
    required this.status,
    required this.reasonCode,
    this.details,
  });

  final LocationIntegrityStatus status;

  final String reasonCode;

  final String? details;

  bool get isAllowed => status == LocationIntegrityStatus.trusted;

  String get messageKey {
    return switch (status) {
      LocationIntegrityStatus.trusted => '',
      LocationIntegrityStatus.mockLocationDetected =>
        'errors.mockLocationDetected',
      LocationIntegrityStatus.locationAnomaly => 'errors.locationAnomaly',
      LocationIntegrityStatus.lowAccuracy => 'errors.locationLowAccuracy',
      LocationIntegrityStatus.unknown => 'errors.locationIntegrityUnknown',
    };
  }
}
