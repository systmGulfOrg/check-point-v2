import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

class AppLogger {
  const AppLogger._();

  static void debug(String message) {
    if (kDebugMode) developer.log(message, name: 'check_point');
  }

  static void error(String message) {
    if (kDebugMode) developer.log(message, name: 'check_point', level: 1000);
  }
}
