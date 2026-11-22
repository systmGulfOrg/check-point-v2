import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

import 'package:check_point_v2/core/app/app_config.dart';
import 'package:check_point_v2/core/bloc/safe_cubit.dart';
import 'package:check_point_v2/core/database/app_database.dart';
import 'connectivity_state.dart';

class ConnectivityCubit extends SafeCubit<ConnectivityState> {
  final Connectivity connectivity;
  final AppDatabase database;
  final Dio probeDio;

  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  StreamSubscription<List<PendingAttendanceTableData>>? _pendingSubscription;
  void Function()? onOnlineRestored;

  ConnectivityCubit({
    Connectivity? connectivity,
    required this.database,
    Dio? probeDio,
  }) : connectivity = connectivity ?? Connectivity(),
       probeDio =
           probeDio ??
           Dio(
             BaseOptions(
               connectTimeout: const Duration(seconds: 3),
               receiveTimeout: const Duration(seconds: 3),
               sendTimeout: const Duration(seconds: 3),
             ),
           ),
       super(const ConnectivityState()) {
    _init();
  }

  void _init() {
    _pendingSubscription =
        (database.select(database.pendingAttendanceTable)
              ..where((tbl) => tbl.status.equals('queued')))
            .watch()
            .listen((records) {
              safeEmit(state.copyWith(pendingCount: records.length));
            });

    _connectivitySubscription = connectivity.onConnectivityChanged.listen((
      results,
    ) {
      checkConnectivity(results);
    });

    checkConnectivity();
  }

  Future<void> checkConnectivity([List<ConnectivityResult>? results]) async {
    final currentResults = results ?? await connectivity.checkConnectivity();
    final hasNetworkInterface = currentResults.any(
      (r) => r != ConnectivityResult.none,
    );

    if (!hasNetworkInterface) {
      _updateOnlineStatus(false);
      return;
    }

    safeEmit(state.copyWith(isChecking: true));
    final isReachable = await _probeServer();
    safeEmit(state.copyWith(isChecking: false));
    _updateOnlineStatus(isReachable);
  }

  Future<bool> _probeServer() async {
    try {
      final probeUrl = '${AppConfig.baseUrl}/health/live';
      final response = await probeDio.get(probeUrl);
      return (response.statusCode ?? 0) >= 200 &&
          (response.statusCode ?? 0) < 400;
    } catch (_) {
      // Secondary check: internet lookup
      try {
        final result = await InternetAddress.lookup(
          'google.com',
        ).timeout(const Duration(seconds: 3));
        return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      } catch (_) {
        return false;
      }
    }
  }

  void _updateOnlineStatus(bool online) {
    final wasOffline = !state.isOnline;
    final didEmit = safeEmit(state.copyWith(isOnline: online));

    if (didEmit && wasOffline && online) {
      onOnlineRestored?.call();
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    _pendingSubscription?.cancel();
    return super.close();
  }
}
