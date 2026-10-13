/// Classification of a location sample's trustworthiness.
enum LocationIntegrityStatus {
  /// All checks passed — location is considered trustworthy.
  trusted,

  /// Native Android API flagged the location as mock.
  mockLocationDetected,

  /// Sequence anomaly detected (impossible speed, position jump, etc.).
  locationAnomaly,

  /// The accuracy is too low to rely on this reading.
  lowAccuracy,

  /// A check could not be performed (e.g. platform unavailable). Treat as
  /// suspicious, not safe.
  unknown,
}

/// Structured outcome of a single integrity assessment.
class LocationIntegrityResult {
  const LocationIntegrityResult({
    required this.status,
    required this.reasonCode,
    this.details,
  });

  final LocationIntegrityStatus status;

  /// Machine-readable reason code for logging.
  final String reasonCode;

  /// Optional human-readable details (not user-facing).
  final String? details;

  bool get isAllowed => status == LocationIntegrityStatus.trusted;

  /// Maps [status] to the localization key used for user-facing messages.
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
