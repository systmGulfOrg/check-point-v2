import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:check_point_v2/core/app/app_config.dart';

class DeviceIdentityProvider {
  DeviceIdentityProvider({this.secureStorage = const FlutterSecureStorage()});

  static const String _mobileIdKey = 'device_mobile_id';

  final FlutterSecureStorage secureStorage;
  String? _storedMobileId;

  Future<void> initialize() async {
    final storedMobileId = await secureStorage.read(key: _mobileIdKey);
    if (storedMobileId != null && storedMobileId.isNotEmpty) {
      _storedMobileId = storedMobileId;
      return;
    }

    final generatedMobileId = _generateUuidV4();
    await secureStorage.write(key: _mobileIdKey, value: generatedMobileId);
    _storedMobileId = generatedMobileId;
  }

  Future<String> getOrGenerateMobileId() async {
    if (_storedMobileId != null && _storedMobileId!.isNotEmpty) {
      return _storedMobileId!;
    }
    final storedMobileId = await secureStorage.read(key: _mobileIdKey);
    if (storedMobileId != null && storedMobileId.isNotEmpty) {
      _storedMobileId = storedMobileId;
      return storedMobileId;
    }
    final generatedMobileId = _generateUuidV4();
    await secureStorage.write(key: _mobileIdKey, value: generatedMobileId);
    _storedMobileId = generatedMobileId;
    return generatedMobileId;
  }

  String get mobileId {
    final mobileId = _storedMobileId;
    if (mobileId == null) {
      throw StateError(
        'DeviceIdentityProvider.initialize() must be called first',
      );
    }
    return mobileId;
  }

  String get deviceToken => AppConfig.deviceToken;

  static String _generateUuidV4() {
    final random = Random.secure();
    final bytes = List<int>.generate(16, (_) => random.nextInt(256));
    bytes[6] = (bytes[6] & 0x0f) | 0x40;
    bytes[8] = (bytes[8] & 0x3f) | 0x80;

    final hex = bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0'));
    final value = hex.join();
    return '${value.substring(0, 8)}-${value.substring(8, 12)}-'
        '${value.substring(12, 16)}-${value.substring(16, 20)}-'
        '${value.substring(20)}';
  }
}
