import 'dart:convert';
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:check_point_v2/features/contractor/data/models/offline_attendance_log_model.dart';
import 'package:check_point_v2/features/contractor/data/repos/contractor_repo.dart';

class OfflineAttendanceSyncService {
  OfflineAttendanceSyncService({
    required this.contractorRepo,
    FlutterSecureStorage? secureStorage,
  }) : secureStorage = secureStorage ?? const FlutterSecureStorage();

  final ContractorRepo contractorRepo;
  final FlutterSecureStorage secureStorage;
  final Connectivity connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? connectivitySubscription;
  static const String _storageKey = 'offline_attendance_punch_queue';

  void startAutoSync() {
    connectivitySubscription ??= connectivity.onConnectivityChanged.listen((
      results,
    ) {
      if (results.any((result) => result != ConnectivityResult.none)) {
        unawaited(syncPendingPunches());
      }
    });
  }

  Future<void> dispose() async {
    await connectivitySubscription?.cancel();
    connectivitySubscription = null;
  }

  Future<List<OfflineAttendanceLogModel>> getPendingPunches() async {
    final rawString = await secureStorage.read(key: _storageKey);
    if (rawString == null || rawString.isEmpty) return [];
    try {
      final decoded = jsonDecode(rawString) as List<dynamic>;
      return decoded.map((item) {
        final json = item as Map<String, dynamic>;
        return OfflineAttendanceLogModel.fromJson(json);
      }).toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> queuePunch(OfflineAttendanceLogModel log) async {
    final current = await getPendingPunches();
    if (current.any((item) => item.localId == log.localId)) return;
    current.add(log);
    final rawString = jsonEncode(current.map((e) => e.toJson()).toList());
    await secureStorage.write(key: _storageKey, value: rawString);
  }

  Future<int> syncPendingPunches() async {
    final pending = await getPendingPunches();
    if (pending.isEmpty) return 0;

    final result = await contractorRepo.syncAttendanceBatch(pending);
    return result.when(
      success: (response) async {
        final rawResults = response['results'];
        if (rawResults is! List) return 0;
        final completedIds = rawResults
            .whereType<Map>()
            .where(
              (item) =>
                  item['status'] == 'synced' || item['status'] == 'ignored',
            )
            .map((item) => item['clientUuid']?.toString())
            .whereType<String>()
            .toSet();
        final remaining = pending
            .where((item) => !completedIds.contains(item.localId))
            .toList();
        if (remaining.isEmpty) {
          await secureStorage.delete(key: _storageKey);
        } else {
          await secureStorage.write(
            key: _storageKey,
            value: jsonEncode(remaining.map((item) => item.toJson()).toList()),
          );
        }
        return completedIds.length;
      },
      failure: (_) => 0,
    );
  }
}
