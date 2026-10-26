import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/app/app_config.dart';
import 'package:check_point_v2/core/database/app_database.dart';
import 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  final Connectivity _connectivity;
  final AppDatabase _database;
  final Dio _probeDio;

  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  StreamSubscription<List<PendingAttendanceTableData>>? _pendingSubscription;
  void Function()? onOnlineRestored;

  ConnectivityCubit({
    Connectivity? connectivity,
    required AppDatabase database,
    Dio? probeDio,
  })  : _connectivity = connectivity ?? Connectivity(),
        _database = database,
        _probeDio = probeDio ??
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
    _pendingSubscription = (_database.select(_database.pendingAttendanceTable)
          ..where((tbl) => tbl.status.equals('queued')))
        .watch()
        .listen((records) {
      if (!isClosed) {
        emit(state.copyWith(pendingCount: records.length));
      }
    });

    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((results) {
      checkConnectivity(results);
    });

    checkConnectivity();
  }

  Future<void> checkConnectivity([List<ConnectivityResult>? results]) async {
    final currentResults = results ?? await _connectivity.checkConnectivity();
    final hasNetworkInterface = currentResults.any((r) => r != ConnectivityResult.none);

    if (!hasNetworkInterface) {
      _updateOnlineStatus(false);
      return;
    }

    emit(state.copyWith(isChecking: true));
    final isReachable = await _probeServer();
    emit(state.copyWith(isChecking: false));
    _updateOnlineStatus(isReachable);
  }

  Future<bool> _probeServer() async {
    try {
      final probeUrl = '${AppConfig.baseUrl}/health/live';
      final response = await _probeDio.get(probeUrl);
      return (response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) < 400;
    } catch (_) {
      // Secondary check: internet lookup
      try {
        final result = await InternetAddress.lookup('google.com')
            .timeout(const Duration(seconds: 3));
        return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      } catch (_) {
        return false;
      }
    }
  }

  void _updateOnlineStatus(bool online) {
    if (isClosed) return;
    final wasOffline = !state.isOnline;
    emit(state.copyWith(isOnline: online));

    if (wasOffline && online) {
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
