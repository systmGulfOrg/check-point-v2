import 'package:flutter_test/flutter_test.dart';
import 'package:check_point_v2/core/services/play_integrity_service.dart';

void main() {
  group('PlayIntegrityService - Canonical JSON and Shared Test Vector', () {
    test('matches the exact shared Node.js backend test vector', () {
      const challenge = 'test-challenge-nonce-1234567890abcdef';
      final canonical = PlayIntegrityService.computeCanonicalJson(
        action: 'clock_in',
        accuracy: 12.54,
        deviceId: 'device-test-uuid-456',
        latitude: 24.7135524,
        longitude: 46.6752968,
        timestamp: 1700000000000,
      );

      expect(
        canonical,
        '{"accuracy":12.5,"action":"clock_in","deviceId":"device-test-uuid-456","latitude":24.713552,"longitude":46.675297,"timestamp":1700000000000}',
      );

      final hash = PlayIntegrityService.computeRequestHash(
        challenge: challenge,
        canonicalJson: canonical,
      );

      expect(hash, 'eet6vX2XroO8ttMzIcXHrzaXZoMVW0M_NXCn5Jhp6XE');
    });

    test('handles null and optional coordinates deterministically', () {
      final canonical = PlayIntegrityService.computeCanonicalJson(
        action: 'login',
        deviceId: 'device-001',
      );

      expect(
        canonical,
        '{"accuracy":0,"action":"login","deviceId":"device-001","latitude":0,"longitude":0,"timestamp":0}',
      );
    });
  });
}
