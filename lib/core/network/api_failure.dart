class ApiFailure {
  const ApiFailure({
    required this.messageKey,
    this.code,
    this.statusCode,
    this.details,
    this.lockoutMinutes,
    this.rawMessage,
  });

  final String messageKey;
  final String? code;
  final int? statusCode;
  final Map<String, dynamic>? details;
  final int? lockoutMinutes;
  final String? rawMessage;

  bool get isAccountLocked =>
      code == 'ACCOUNT_LOCKED' || messageKey == 'errors.accountLocked';

  bool get isOutsideZone =>
      code == 'OUTSIDE_ZONE' ||
      messageKey == 'errors.outsideZone' ||
      messageKey == 'auth.login.outsideZoneMessage';

  bool get isDeviceNotApproved =>
      code == 'DEVICE_NOT_APPROVED' ||
      messageKey == 'errors.deviceLoginAccess' ||
      messageKey == 'errors.deviceNotApproved';
}
