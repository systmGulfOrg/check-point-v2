import 'dart:async';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart';

import 'package:check_point_v2/core/auth/auth_session_storage.dart';
import 'package:check_point_v2/core/database/app_database.dart';
import 'package:check_point_v2/core/models/offline_attendance_models.dart';
import 'package:check_point_v2/core/network/api_constants.dart';
import 'package:check_point_v2/core/services/local_notification_service.dart';
import 'package:check_point_v2/core/utils/uuid_helper.dart';

class AttendanceSyncService {
  final AppDatabase database;
  final Dio dio;
  final AuthSessionStorage sessionStorage;
  final LocalNotificationService? localNotificationService;

  bool _isSyncing = false;

  AttendanceSyncService({
    required this.database,
    required this.dio,
    required this.sessionStorage,
    this.localNotificationService,
  });

  bool get isSyncing => _isSyncing;

  Future<String> enqueue({
    required String type, // 'in' | 'out'
    required DateTime wallClock,
    required int monotonicMs,
    required String bootId,
    DateTime? anchorServerTime,
    int? anchorMonotonicMs,
    String? anchorBootId,
    double? latitude,
    double? longitude,
    double? accuracyM,
    bool mockLocationDetected = false,
    String? area,
    String? customerId,
  }) async {
    final clientUuid = UuidHelper.generateV4();
    await database.into(database.pendingAttendanceTable).insert(
          PendingAttendanceTableCompanion.insert(
            clientUuid: clientUuid,
            type: type,
            wallClock: wallClock.toUtc(),
            monotonicMs: BigInt.from(monotonicMs),
            bootId: bootId,
            anchorServerTime: Value(anchorServerTime?.toUtc()),
            anchorMonotonicMs: Value(
              anchorMonotonicMs != null ? BigInt.from(anchorMonotonicMs) : null,
            ),
            anchorBootId: Value(anchorBootId),
            latitude: Value(latitude),
            longitude: Value(longitude),
            accuracyM: Value(accuracyM),
            mockLocationDetected: Value(mockLocationDetected),
            area: Value(area),
            customerId: Value(customerId),
            status: const Value('queued'),
            createdAt: DateTime.now().toUtc(),
          ),
        );
    return clientUuid;
  }

  Future<OfflineSyncResponse?> syncPending() async {
    if (_isSyncing) return null;
    _isSyncing = true;

    try {
      final token = await sessionStorage.readToken();
      if (token == null || token.isEmpty) {
        return null;
      }

      final payload = AuthSessionStorage.decodeJwtPayload(token);
      final exp = payload?['exp'] as int?;
      if (exp != null) {
        final expiresAt = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
        if (DateTime.now().isAfter(expiresAt)) {
          // Token expired, wait for next login before draining
          return null;
        }
      }

      final pendingRows = await (database.select(database.pendingAttendanceTable)
            ..where((tbl) => tbl.status.equals('queued'))
            ..orderBy([(tbl) => OrderingTerm.asc(tbl.createdAt)]))
          .get();

      if (pendingRows.isEmpty) {
        return null;
      }

      final records = pendingRows.map((row) {
        OfflineSyncAnchor? anchor;
        if (row.anchorServerTime != null &&
            row.anchorMonotonicMs != null &&
            row.anchorBootId != null) {
          anchor = OfflineSyncAnchor(
            serverTime: row.anchorServerTime!,
            monotonicMs: row.anchorMonotonicMs!.toInt(),
            bootId: row.anchorBootId!,
          );
        }

        return OfflineSyncRecord(
          clientUuid: row.clientUuid,
          type: row.type,
          wallClock: row.wallClock,
          monotonicMs: row.monotonicMs.toInt(),
          bootId: row.bootId,
          anchor: anchor,
          latitude: row.latitude,
          longitude: row.longitude,
          accuracy: row.accuracyM,
          mockLocationDetected: row.mockLocationDetected,
          area: row.area,
          customerId: row.customerId,
        );
      }).toList();

      final requestData = {
        'records': records.map((r) => r.toJson()).toList(),
      };

      final response = await dio.post(
        ApiConstants.offlineAttendanceSync,
        data: requestData,
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        final syncResponse = OfflineSyncResponse.fromJson(
          response.data as Map<String, dynamic>,
        );

        for (final item in syncResponse.results) {
          final mappedStatus = switch (item.status) {
            'VERIFIED' => 'synced',
            'PENDING_VERIFICATION' => 'pending',
            'CONFLICT' => 'conflict',
            _ => 'rejected',
          };

          await (database.update(database.pendingAttendanceTable)
                ..where((tbl) => tbl.clientUuid.equals(item.clientUuid)))
              .write(
            PendingAttendanceTableCompanion(
              status: Value(mappedStatus),
              reason: Value(item.reasons.isNotEmpty ? item.reasons.join(',') : null),
            ),
          );
        }

        // Show local notification if items were synced
        if (syncResponse.verified > 0 || syncResponse.pending > 0) {
          final title = syncResponse.pending > 0
              ? 'مزامنة الحضور: بانتظار الاعتماد'
              : 'تمت مزامنة الحضور';
          final body = syncResponse.pending > 0
              ? 'تم إرسال ${syncResponse.total} سجل، منها ${syncResponse.pending} بانتظار اعتماد المشرف.'
              : 'تم اعتماد ${syncResponse.verified} سجل حضور بنجاح.';

          await localNotificationService?.showPush(
            id: 2001,
            title: title,
            body: body,
          );
        }

        return syncResponse;
      }
    } catch (_) {
      // Network error or retryable failure - keep queued items for next sync attempt
    } finally {
      _isSyncing = false;
    }
    return null;
  }
}
