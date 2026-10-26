import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
// ignore: depend_on_referenced_packages
import 'package:sqlite3/open.dart';

import 'package:check_point_v2/core/auth/auth_session_storage.dart';
import 'package:check_point_v2/core/database/app_database.dart';
import 'package:check_point_v2/core/services/attendance_sync_service.dart';

class FakeSecureStorage extends FlutterSecureStorage {
  final Map<String, String> _data = {};

  @override
  Future<void> write({
    required String key,
    required String? value,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    if (value != null) {
      _data[key] = value;
    } else {
      _data.remove(key);
    }
  }

  @override
  Future<String?> read({
    required String key,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    return _data[key];
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    if (Platform.isLinux) {
      open.overrideFor(OperatingSystem.linux, () {
        return DynamicLibrary.open(
          '/usr/lib/x86_64-linux-gnu/libsqlite3.so.0',
        );
      });
    }
  });

  late AppDatabase db;
  late FakeSecureStorage secureStorage;
  late AuthSessionStorage sessionStorage;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    secureStorage = FakeSecureStorage();
    sessionStorage = AuthSessionStorage(secureStorage: secureStorage);
  });

  tearDown(() async {
    await db.close();
  });

  String createTestJwt({required int expSecondsFromNow}) {
    final header = base64Url.encode(utf8.encode(jsonEncode({'alg': 'HS256', 'typ': 'JWT'}))).replaceAll('=', '');
    final exp = (DateTime.now().millisecondsSinceEpoch ~/ 1000) + expSecondsFromNow;
    final payload = base64Url.encode(utf8.encode(jsonEncode({
      'userId': 'usr-1',
      'employeeId': 'emp-1',
      'tenantId': 'tenant-1',
      'exp': exp,
    }))).replaceAll('=', '');
    return '$header.$payload.signature';
  }

  test('AttendanceSyncService enqueues record into local db with status queued', () async {
    final service = AttendanceSyncService(
      database: db,
      dio: Dio(),
      sessionStorage: sessionStorage,
    );

    final now = DateTime.now().toUtc();
    final uuid = await service.enqueue(
      type: 'in',
      wallClock: now,
      monotonicMs: 12345,
      bootId: 'boot-1',
      latitude: 24.7,
      longitude: 46.7,
      area: 'Office',
    );

    expect(uuid, isNotEmpty);
    final rows = await db.select(db.pendingAttendanceTable).get();
    expect(rows.length, 1);
    expect(rows.first.clientUuid, uuid);
    expect(rows.first.type, 'in');
    expect(rows.first.status, 'queued');
    expect(rows.first.area, 'Office');
  });

  test('AttendanceSyncService keeps queue intact when JWT is expired', () async {
    final expiredToken = createTestJwt(expSecondsFromNow: -3600); // 1 hr in past
    await sessionStorage.saveUserSession(token: expiredToken);

    final service = AttendanceSyncService(
      database: db,
      dio: Dio(),
      sessionStorage: sessionStorage,
    );

    await service.enqueue(
      type: 'in',
      wallClock: DateTime.now().toUtc(),
      monotonicMs: 1000,
      bootId: 'boot-1',
    );

    final syncResult = await service.syncPending();
    expect(syncResult, isNull);

    // Queue must still have the item with status 'queued'
    final rows = await db.select(db.pendingAttendanceTable).get();
    expect(rows.length, 1);
    expect(rows.first.status, 'queued');
  });
}
