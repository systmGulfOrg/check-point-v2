import 'dart:io';
import 'package:dio/dio.dart';

import 'package:check_point_v2/core/database/app_database.dart';
import 'package:check_point_v2/core/services/device_clock_service.dart';

class ServerTimeAnchorInterceptor extends Interceptor {
  final AppDatabase database;
  final DeviceClockService deviceClockService;

  ServerTimeAnchorInterceptor({
    required this.database,
    required this.deviceClockService,
  });

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    final statusCode = response.statusCode ?? 0;
    if (statusCode >= 200 && statusCode < 300) {
      final dateHeader = response.headers.value('date');
      if (dateHeader != null && dateHeader.isNotEmpty) {
        DateTime? serverTime;
        try {
          serverTime = HttpDate.parse(dateHeader);
        } catch (_) {
          serverTime = DateTime.tryParse(dateHeader);
        }

        if (serverTime != null) {
          try {
            final snapshot = await deviceClockService.getClockSnapshot();
            await database.into(database.timeAnchors).insert(
                  TimeAnchorsCompanion.insert(
                    serverTime: serverTime.toUtc(),
                    monotonicMs: BigInt.from(snapshot.monotonicMs),
                    bootId: snapshot.bootId,
                    recordedAt: DateTime.now().toUtc(),
                  ),
                );
          } catch (_) {
            // Non-blocking: recording the anchor must not fail the response
          }
        }
      }
    }
    handler.next(response);
  }
}
