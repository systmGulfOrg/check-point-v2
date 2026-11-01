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

  /// The backend accepts at most this many records per request.
  static const int _batchSize = 50;

  final _syncCompleted = StreamController<OfflineSyncResponse>.broadcast();

  /// Emits after each sync that changed at least one queued record, so screens
  /// showing today's attendance can reload from the server.
  Stream<OfflineSyncResponse> get syncCompleted => _syncCompleted.stream;

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
    await database
        .into(database.pendingAttendanceTable)
        .insert(
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

      final pendingRows =
          await (database.select(database.pendingAttendanceTable)
                ..where((tbl) => tbl.status.equals('queued'))
                ..orderBy([(tbl) => OrderingTerm.asc(tbl.createdAt)]))
              .get();

      if (pendingRows.isEmpty) {
        return null;
      }

      final allResults = <OfflineSyncResultItem>[];
      for (var i = 0; i < pendingRows.length; i += _batchSize) {
        final batch = pendingRows.skip(i).take(_batchSize).toList();
        final response = await dio.post(
          ApiConstants.offlineAttendanceSync,
          data: {
            'records': batch.map(_toRecord).map((r) => r.toJson()).toList(),
          },
        );
        final parsed = OfflineSyncResponse.fromJson(
          response.data as Map<String, dynamic>,
        );
        for (final item in parsed.results) {
          await (database.update(
            database.pendingAttendanceTable,
          )..where((tbl) => tbl.clientUuid.equals(item.clientUuid))).write(
            PendingAttendanceTableCompanion(
              status: Value(_localStatus(item.status)),
              reason: Value(
                item.reasons.isNotEmpty ? item.reasons.join(',') : null,
              ),
            ),
          );
        }
        allResults.addAll(parsed.results);
      }

      final summary = OfflineSyncResponse(
        total: allResults.length,
        verified: allResults
            .where((r) => r.status == 'synced' || r.status == 'duplicate')
            .length,
        pending: allResults.where((r) => r.status == 'pending').length,
        failed: allResults
            .where((r) => r.status == 'conflict' || r.status == 'rejected')
            .length,
        results: allResults,
      );

      if (summary.total > 0) _syncCompleted.add(summary);
      await _notifyOutcome(summary);
      return summary;
    } catch (_) {
      // Network error or retryable failure: rows not acknowledged by the
      // server stay 'queued' and are retried on the next sync.
    } finally {
      _isSyncing = false;
    }
    return null;
  }

  /// Queued (not yet sent) records captured on [day] in local time, oldest
  /// first. Records from other days are never shown as today's attendance.
  Future<List<PendingAttendanceTableData>> queuedForDay(DateTime day) async {
    final rows =
        await (database.select(database.pendingAttendanceTable)
              ..where((tbl) => tbl.status.equals('queued'))
              ..orderBy([(tbl) => OrderingTerm.asc(tbl.wallClock)]))
            .get();
    return rows.where((row) {
      final local = row.wallClock.toLocal();
      return local.year == day.year &&
          local.month == day.month &&
          local.day == day.day;
    }).toList();
  }

  OfflineSyncRecord _toRecord(PendingAttendanceTableData row) {
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
  }

  /// Maps the server's per-record status onto the local queue status.
  /// `duplicate` means the server already holds this exact record.
  static String _localStatus(String serverStatus) => switch (serverStatus) {
    'synced' || 'duplicate' => 'synced',
    'pending' => 'pending',
    'conflict' => 'conflict',
    _ => 'rejected',
  };

  Future<void> _notifyOutcome(OfflineSyncResponse summary) async {
    if (summary.verified == 0 && summary.pending == 0) return;
    final title = summary.pending > 0
        ? 'مزامنة الحضور: بانتظار الاعتماد'
        : 'تمت مزامنة الحضور';
    final body = summary.pending > 0
        ? 'تم إرسال ${summary.total} سجل، منها ${summary.pending} بانتظار اعتماد المشرف.'
        : 'تم اعتماد ${summary.verified} سجل حضور بنجاح.';
    await localNotificationService?.showPush(
      id: 2001,
      title: title,
      body: body,
    );
  }

  Future<void> dispose() => _syncCompleted.close();
}
